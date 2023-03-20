using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DovizWebServisi.Models
{
    public class DovizKurlari
    {
        public int Id { get; set; }
        public DateTime? Tarih { get; set; }
        public string Birim { get; set; }
        public string KurAdi { get; set; }
        public string ParaBirimi { get; set; }
        public double? DegerAlis { get; set; }
        public double? DegerSatis { get; set; }
        public double? EfektifAlis { get; set; }
        public double? EfektifSatis { get; set; }
    }
}