module cef_base;
import derelict.cef.cef;
import core.stdc.stdio;
import core.stdc.stdlib;

extern(Windows) {
	int add_ref(cef_base_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("cef_base_t.add_ref\n");
		// if (DEBUG_REFERENCE_COUNTING)
			printf("+");
		return 1;
	}

	int release(cef_base_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("cef_base_t.release\n");
		// if (DEBUG_REFERENCE_COUNTING)
			printf("-");
		return 1;
	}

	int get_refct(cef_base_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("cef_base_t.get_refct\n");
		// if (DEBUG_REFERENCE_COUNTING)
			printf("=");
		return 1;
	}

	void initialize_cef_base_ref_counted(cef_base_t* base) {
		printf("initialize_cef_base_ref_counted\n");
		// Check if "size" member was set.
		// Let's print the size in case sizeof was used
		// on a pointer instead of a structure. In such
		// case the number will be very high.
		// printf("cef_base_t.size = %lu\n", cast(ulong)size);
		if (base.size <= 0) {
			printf("FATAL: initialize_cef_base failed, size member not set\n");
			// _exit(1);
			exit(1);
		}
		base.add_ref = &add_ref;
		base.release = &release;
		base.get_refct = &get_refct;
	}
}