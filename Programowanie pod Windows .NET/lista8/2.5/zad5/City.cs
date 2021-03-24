using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad5
{
    public class City
    {
        [Key]
        public string CityName { get; set; }
        public virtual ICollection<Student> Students { get; set; }
    }
}
