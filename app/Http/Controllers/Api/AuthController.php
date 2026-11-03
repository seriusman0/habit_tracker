<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate(['email'=>'required|email','password'=>'required','device_name'=>'required|string']);
        $user = User::where('email',$request->email)->first();
        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages(['email'=>['Kredensial salah.']]);
        }
        $token = $user->createToken($request->device_name)->plainTextToken;
        return response()->json(['token'=>$token,'user'=>['id'=>$user->id,'name'=>$user->name,'email'=>$user->email,'roles'=>$user->getRoleNames()]]);
    }

    public function register(Request $request)
    {
        $validated = $request->validate([
            'name'=>'required|string|max:255',
            'email'=>'required|email|unique:users,email',
            'password'=>'required|string|min:8|confirmed',
            'device_name'=>'required|string',
        ]);
        $user = User::create([
            'name'=>$validated['name'],
            'email'=>$validated['email'],
            'password'=>Hash::make($validated['password']),
        ]);
        $user->assignRole('student');
        $token = $user->createToken($validated['device_name'])->plainTextToken;
        return response()->json(['token'=>$token,'user'=>['id'=>$user->id,'name'=>$user->name,'email'=>$user->email,'roles'=>$user->getRoleNames()]],201);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->noContent();
    }

    public function user(Request $request)
    {
        $u = $request->user();
        return response()->json(['id'=>$u->id,'name'=>$u->name,'email'=>$u->email,'roles'=>$u->getRoleNames()]);
    }
}
