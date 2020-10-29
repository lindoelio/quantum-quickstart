namespace quantumConsoleQuickstart {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 50;
        let min = 30;

        SayHello(max, min);

        return SampleRandomNumberInRange(max, min);
    }

    operation SayHello(maxNumber: Int, minNumber : Int) : Unit {
        Message($"Sampling a random number between {minNumber} and {maxNumber}: ");
    }

    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        using (qubit = Qubit()) {
            // Put the qubit to superposition.
            H(qubit);
            // It now has a 50% chance of being measured 0 or 1.
            // Measure the qubit value.
            return MResetZ(qubit);
        }
    }

    operation SampleRandomNumberInRange(max : Int, min : Int) : Int {
        mutable output = 0;

        repeat {
            mutable bits = new Result[0];

            for (idxBit in 1..BitSizeI(max)) {
                set bits += [GenerateRandomBit()];
            }

            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max);

        return output;
    }
}
