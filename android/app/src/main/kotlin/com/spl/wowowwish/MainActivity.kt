package com.spl.wowowwish

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//
//        Timer("ChangingTaskDescriptionColor", false).schedule(1000) {
//            val taskDescription: ActivityManager.TaskDescription =
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
//                    //android 9.0
//                    setTaskDescriptionP()
//                } else {
//                    setTaskDescriptionBeforeP()
//                }
//            setTaskDescription(taskDescription)
//        }
//
//    }
//
//    private fun setTaskDescriptionBeforeP(): ActivityManager.TaskDescription {
//        val bitmapIcon = BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher)
//        return ActivityManager.TaskDescription("WoWoW许愿啦", bitmapIcon, Color.RED)
//    }
//
//    @TargetApi(Build.VERSION_CODES.P)
//    private fun setTaskDescriptionP(): ActivityManager.TaskDescription {
//        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//            ActivityManager.TaskDescription.Builder().setLabel("WoWoW许愿啦")
//                .setIcon(R.mipmap.ic_launcher)
//                .setPrimaryColor(Color.RED).build()
//        } else ActivityManager.TaskDescription("WoWoW许愿啦", R.mipmap.ic_launcher, Color.RED)
//
//    }
}

