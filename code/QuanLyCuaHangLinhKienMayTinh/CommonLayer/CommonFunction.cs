﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommonLayer
{
    public class CommonFunction
    {

        public static bool IntToBool(int n)
        {
            return n == 0 ? false : true;
        }

        public static int BoolToInt(bool b)
        {
            return b == false ? 0 : 1;
        }
    }
}
