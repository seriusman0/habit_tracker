<template>
    <div class="p-6 bg-white rounded-lg shadow">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Habit Assignment</h3>
        <div class="flex gap-6">
            <!-- Habits (Source) -->
            <div class="w-1/3">
                <h4 class="font-semibold mb-2">Habit Templates</h4>
                <draggable
                    v-model="templates"
                    :group="{ name: 'habits', pull: 'clone', put: false }"
                    :sort="false"
                    item-key="id"
                    class="space-y-2"
                >
                    <template #item="{ element }">
                        <div
                            class="p-3 bg-blue-50 border border-blue-200 rounded cursor-move hover:bg-blue-100"
                        >
                            <span class="font-medium text-blue-900">{{
                                element.title
                            }}</span>
                            <p class="text-xs text-blue-700">
                                {{ element.frequency }}
                            </p>
                        </div>
                    </template>
                </draggable>
                <div
                    v-if="templates.length === 0"
                    class="text-sm text-gray-500 italic"
                >
                    No templates found. Create 'global' habits (no student) to
                    see them here.
                </div>
            </div>

            <!-- Students (Targets) -->
            <div class="w-2/3">
                <h4 class="font-semibold mb-2">Classroom Students</h4>
                <div class="space-y-4">
                    <div
                        v-for="student in students"
                        :key="student.id"
                        class="border rounded-lg p-4 bg-gray-50"
                    >
                        <div class="flex justify-between items-center mb-2">
                            <span class="font-medium">{{ student.name }}</span>
                            <span
                                class="text-xs bg-gray-200 px-2 py-1 rounded"
                                >{{ student.email }}</span
                            >
                        </div>

                        <!-- Drop Zone for each student -->
                        <draggable
                            :list="student.habits"
                            group="habits"
                            item-key="id"
                            class="min-h-[60px] bg-white border border-dashed border-gray-300 rounded p-2"
                            @change="(evt) => onDrop(evt, student)"
                        >
                            <template #item="{ element }">
                                <div
                                    class="p-2 mb-1 bg-green-50 border border-green-200 rounded text-sm relative group"
                                >
                                    {{ element.title }}
                                    <!-- Visual indicator that this is a persistent habit -->
                                    <span
                                        class="hidden group-hover:inline absolute right-2 text-green-600 text-xs"
                                        >Assigned</span
                                    >
                                </div>
                            </template>
                        </draggable>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import draggable from "vuedraggable";
import axios from "axios";

const props = defineProps({
    classroomId: {
        type: [Number, String],
        required: true,
    },
});

const templates = ref([]);
const students = ref([]);

const fetchData = async () => {
    try {
        const response = await axios.get(
            `/mentor/api/classrooms/${props.classroomId}`,
        );
        templates.value = response.data.templates;
        // Initialize student habits list if empty/null
        students.value = response.data.students.map((s) => ({
            ...s,
            habits: s.habits || [],
        }));
    } catch (error) {
        console.error("Error fetching data:", error);
        alert("Failed to load classroom data.");
    }
};

const onDrop = async (event, student) => {
    if (event.added) {
        const habitTemplate = event.added.element;
        // Optimization: UI already shows the item (cloned).
        // Actual server assignment:
        try {
            const response = await axios.post(
                `/mentor/api/classrooms/${props.classroomId}/assign`,
                {
                    student_id: student.id,
                    habit_id: habitTemplate.id,
                },
            );
            console.log("Assigned:", response.data);
            // Verify/Update the habit in the list with the real one from DB if needed
            // But 'added' element is the template copy.
            // Ideally we replace it with the new DB record, but for visual feedback it's fine.
            // Let's at least visually indicate success or toast.
            // alert(`Habit assigned to ${student.name}`);
        } catch (error) {
            console.error("Assignment failed", error);
            alert("Failed to assign habit.");
            // Revert UI change? Complex with draggable clone.
            // For MVP, assume success or reload.
            // window.location.reload(); // excessive
        }
    }
};

onMounted(() => {
    fetchData();
});
</script>

<style scoped>
.ghost {
    opacity: 0.5;
    background: #c8ebfb;
}
</style>
