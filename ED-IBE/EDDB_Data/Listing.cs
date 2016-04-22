﻿// Generated by Xamasoft JSON Class Generator
// http://www.xamasoft.com/json-class-generator

using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace IBE.EDDB_Data
{

    public class Listing
    {

        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("station_id")]
        public int StationId { get; set; }

        [JsonProperty("commodity_id")]
        public int CommodityId { get; set; }

        [JsonProperty("supply")]
        public int Supply { get; set; }

        public String SupplyLevel { get; set; }

        [JsonProperty("buy_price")]
        public int BuyPrice { get; set; }

        [JsonProperty("sell_price")]
        public int SellPrice { get; set; }

        [JsonProperty("demand")]
        public int Demand { get; set; }

        public String DemandLevel { get; set; }

        [JsonProperty("collected_at")]
        public long CollectedAt { get; set; }

        [JsonProperty("update_count")]
        public int UpdateCount { get; set; }

        public String DataSource { get; set; }

        public Listing()
        {
        }

        public Listing(String listingString)
        {
            try
            {
                FromString(listingString);
            }
            catch (Exception ex)
            {
                throw new Exception("Error while creating CsvEDDBRow object", ex);
            }
        }

        public override String ToString()
        {
            throw new NotImplementedException();

            //return SystemName + ";" +
            //            StationID.Replace(" [" + SystemName + "]", "") + ";" +
            //            CommodityName + ";" +
            //            (SellPrice != 0 ? SellPrice.ToString(CultureInfo.InvariantCulture) : "") + ";" +
            //            (BuyPrice != 0 ? BuyPrice.ToString(CultureInfo.InvariantCulture) : "") + ";" +
            //            (Demand != 0 ? Demand.ToString(CultureInfo.InvariantCulture) : "") + ";" +
            //            DemandLevel + ";" +
            //            (Supply != 0 ? Supply.ToString(CultureInfo.InvariantCulture) : "") + ";" +
            //            SupplyLevel + ";" +
            //            SampleDate.ToString("s", CultureInfo.CurrentCulture).Substring(0, 16) + ";" +
            //            SourceFileName + ";" +
            //            DataSource;
        }

        /// <summary>
        /// converts a csv row to classobject CsvEDDBRow
        /// </summary>
        /// <param name="listingString"></param>
        /// <returns></returns>
        public void FromString(String CsvString)
        {
            try
            {
                String[] Parts = CsvString.Split(',');

                if(Parts.GetUpperBound(0) == 8)
                {
                    Id              = Int32.Parse(Parts[0]);
                    StationId       = Int32.Parse(Parts[1]);
                    CommodityId     = Int32.Parse(Parts[2]);
                    Supply          = Int32.Parse(Parts[3]);
                    BuyPrice        = Int32.Parse(Parts[4]);
                    SellPrice       = Int32.Parse(Parts[5]);
                    Demand          = Int32.Parse(Parts[6]);
                    CollectedAt     = long.Parse(Parts[7]);
                    UpdateCount     = Int32.Parse(Parts[8]);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error while converting csv row to class CsvEDDBRow", ex);
            }
        }
    }
}
