#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <libperf-jvmti.so path>"
    exit 1
fi

# Check if Maven (mvn) is installed
if ! command -v mvn &> /dev/null
then
    echo "Maven (mvn) is not installed. Please install Maven and try again."
    exit 1
fi




# Assign arguments to variables
jvmtisopath=$1

rm -rf results

cd jecoli || exit
mvn clean compile compiler:testCompile
cd ..
./record.sh "$jvmtisopath" jecoli/target/classes:jecoli/target/test-classes pt.uminho.ceb.biosystems.jecoli.demos.countones.CountOnesEATest
./record.sh "$jvmtisopath" jecoli/target/classes:jecoli/target/test-classes pt.uminho.ceb.biosystems.jecoli.demos.countones.CountOnesCAGATest

cd tese || exit
mvn clean compile dependency:copy-dependencies
cd ..
./record.sh "$jvmtisopath" tese/target/classes:tese/target/dependency/fastutil-8.2.2.jar com.issougames.tese.tests.boxed.FastUtil
./record.sh "$jvmtisopath" tese/target/classes:tese/target/dependency/fastutil-8.2.2.jar com.issougames.tese.tests.primitive.FastUtil
./record.sh "$jvmtisopath" tese/target/classes:tese/target/dependency/gs-collections-7.0.3.jar:tese/target/dependency/gs-collections-api-7.0.3.jar com.issougames.tese.tests.boxed.GSCollection
./record.sh "$jvmtisopath" tese/target/classes:tese/target/dependency/gs-collections-7.0.3.jar:tese/target/dependency/gs-collections-api-7.0.3.jar com.issougames.tese.tests.primitive.GSCollection
./record.sh "$jvmtisopath" tese/target/classes:tese/target/dependency/trove4j-3.0.3.jar com.issougames.tese.tests.primitive.Trove
./record.sh "$jvmtisopath" tese/target/classes com.issougames.tese.tests.boxed.JCF
./record.sh "$jvmtisopath" tese/target/classes com.issougames.tese.tests.primitive.JCF