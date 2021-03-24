using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace zad6Klasa
{
    [Serializable()]
    public class Class : ISerializable
    {
        int v;

        public Class(int val)
        {
            this.v = val;
        }

        public Class(SerializationInfo info, StreamingContext context)
        {
            v = (int)info.GetValue("v", typeof(int));
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("v", v);
        }

        public override string ToString()
        {
            return v.ToString();
        }
    }
}
