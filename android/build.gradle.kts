allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

// Note: OpenCV has been removed - now using egyptian_id_parser 1.1.0 package directly
// All ID card parsing and data extraction is handled by the egyptian_id_parser Dart package

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Fix "android:attr/lStar not found" in flutter_nfc_reader: use older androidx.core only for this plugin
subprojects {
    if (project.name == "flutter_nfc_reader") {
        project.configurations.all {
            resolutionStrategy {
                force("androidx.core:core:1.6.0")
                force("androidx.core:core-ktx:1.6.0")
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
