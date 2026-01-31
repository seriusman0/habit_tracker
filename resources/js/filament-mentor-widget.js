import { createApp } from "vue";
import HabitAssignmentWidget from "./Components/HabitAssignmentWidget.vue";

const widgetEl = document.getElementById("habit-assignment-widget");

if (widgetEl) {
    const classroomId = widgetEl.dataset.classroomId;
    const app = createApp(HabitAssignmentWidget, { classroomId });
    app.mount(widgetEl);
}
