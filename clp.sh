cd ~/Proyectos/mineanim-1.21.11

# Backup del actual
cp .classpath .classpath.backup

# Encontrar los JARs
MINECRAFT_JAR=$(find "$PWD/.gradle/loom-cache" -name "minecraft-merged-*.jar" -not -name "*-sources.jar" | head -1)
MINECRAFT_SOURCES=$(find "$PWD/.gradle/loom-cache" -name "minecraft-merged-*-sources.jar" | head -1)
FABRIC_LOADER=$(find ~/.gradle/caches/modules-2/files-2.1/net.fabricmc/fabric-loader/0.18.1 -name "fabric-loader-*.jar" -not -name "*-sources.jar" | head -1)
FABRIC_API=$(find ~/.gradle/caches/modules-2/files-2.1/net.fabricmc.fabric-api/fabric-api -name "fabric-api-0.138.4*.jar" -not -name "*-sources.jar" | head -1)

echo "Minecraft JAR: $MINECRAFT_JAR"
echo "Minecraft Sources: $MINECRAFT_SOURCES"
echo "Fabric Loader: $FABRIC_LOADER"
echo "Fabric API: $FABRIC_API"

# Crear nuevo .classpath
cat > .classpath << EOF
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
	<classpathentry kind="src" output="bin/main" path="src/main/java">
		<attributes>
			<attribute name="gradle_scope" value="main"/>
			<attribute name="gradle_used_by_scope" value="main,test"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="src" output="bin/main" path="src/main/resources">
		<attributes>
			<attribute name="gradle_scope" value="main"/>
			<attribute name="gradle_used_by_scope" value="main,test"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-21/">
		<attributes>
			<attribute name="module" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="lib" path="$MINECRAFT_JAR" sourcepath="$MINECRAFT_SOURCES">
		<attributes>
			<attribute name="gradle_used_by_scope" value="main,test"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="lib" path="$FABRIC_LOADER">
		<attributes>
			<attribute name="gradle_used_by_scope" value="main,test"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="lib" path="$FABRIC_API">
		<attributes>
			<attribute name="gradle_used_by_scope" value="main,test"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="output" path="bin/default"/>
</classpath>
EOF

echo ""
echo "✓ .classpath creado"
echo ""
echo "Verificando JARs en .classpath:"
cat .classpath | grep 'kind="lib"'
