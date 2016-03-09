require_relative '../test_helper'
require 'tiny_etl/reducers/contentdm_extractor'
require 'digest'

class ContentdmTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:base_uri) { "https://server16022.contentdm.oclc.org/dmwebservices/index.php" }
  let(:extractor) { TinyEtl::ContentdmExtractor.new(args: {base_uri: base_uri}, state: {}) }

  def test_record
    expected = {"title"=>"Aerial Lift Bridge: View of Duluth Harbor and West Duluth, Minnesota", "photog"=>"Gallagher, Louis P., 1875-1945", "contri"=>"Gallagher Studio (Duluth, Minnesota)", "descri"=>"View of West Duluth facing downtown Duluth and Lake Superior. The image includes the Duluth Missabe and Iron Range railroad ore docks, grain elevators on Rice's Point, the Aerial Lift Bridge, Minnesota Point, and Lake Superior. Wade Stadium is visible in the center of the picture to the left of the ore docks, with Wheeler Field, 3501 Grand Avenue, to the left of the stadium. Denfeld High School, 4405 West Fourth Street, is in the center of the bottom portion of the image with the West Junior High below it at the southwest corner of North Central Avenue and West Sixth Street. The Interstate Bridge connects Duluth and Superior, Wisconsin at Rice's Point. The Duluth Missabe and Iron Range railroad tracks are at the lower left, continuing to the ore docks where three vessels are waiting to be loaded with ore.", "dat"=>"1950?", "publia"=>{}, "dimens"=>"40.6 x 50.8", "genera"=>"Transportation", "type"=>"Still Image", "physic"=>"Black-and-white photographs;", "specif"=>"Movable bridges; Bridges Minnesota", "subjec"=>"Ore Docks; West Duluth; Wade Stadium; Duluth Missabe and Iron Range Railroad", "city"=>"Duluth", "distri"=>"West Duluth", "county"=>"St. Louis", "state"=>"Minnesota", "countr"=>"United States", "geogra"=>"Lake Superior", "latitu"=>{}, "longit"=>{}, "geogrb"=>{}, "langua"=>{}, "par"=>{}, "contra"=>"University of Minnesota Duluth, Kathryn A. Martin Library, Northeast Minnesota Historical Center Collections", "contac"=>"University of Minnesota Duluth, Kathryn A. Martin Library, Northeast Minnesota Historical Center Collections, 416 Library Drive, Duluth, MN 55812-3001 www.d.umn.edu/lib/archives/archives-special-collections.htm", "righta"=>"It is not necessary to seek the Library’s permission as the owner of the physical work to publish or otherwise use public domain materials that the Library has made available either online or directly to you from our collections. This applies whether your use is non-commercial or commercial. Click here for more information: http://libguides.d.umn.edu/archives/research", "identi"=>"2157.6 S4475 B5 \"O\"", "resour"=>"umn81170", "projec"=>"Minnesota Reflections 2009-10", "fiscal"=>"Grant provided to the Minnesota Digital Library Coalition through the Library Services and Technology Act (LSTA) and the State Library Services and School Technology unit of the Minnesota Department of Education", "publis"=>"University of Minnesota", "date"=>"11/17/2009 10:05", "format"=>"image/jp2", "digspe"=>"image/tiff", "digspa"=>"103157796", "digspb"=>"24", "digspc"=>"300", "digspd"=>"none", "digspf"=>"6516", "digspg"=>"5277", "digsph"=>"Epson 10000XL scanner", "digspi"=>"Adobe Photoshop CS", "digspj"=>"Windows XP", "digspk"=>"fcee89d8b30772b38a2e3674c5d7e17e", "transc"=>{}, "transl"=>{}, "fullrs"=>{}, "find"=>"1745.jp2", "dmaccess"=>{}, "dmimage"=>{}, "dmcreated"=>"2010-05-13", "dmmodified"=>"2014-10-01", "dmoclcno"=>"688657110", "dmrecord"=>"4080", "restrictionCode"=>"1", "cdmfilesize"=>"2715264", "cdmfilesizeformatted"=>"2.59 MB", "cdmprintpdf"=>"0", "cdmhasocr"=>"0", "cdmisnewspaper"=>"0", :id=>"nemhc:4080", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nemhc&CISOPTR=4080&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000", :record_type=>"single"}
    assert_equal expected, extractor.build_record(identifiers: {collection: 'nemhc', identifier: 4080})
  end

  def test_compound_record
    expected = {"title"=>"Heatwole's Dairy Paper, Volume I, Number 1, March 1906", "photog"=>{}, "contri"=>"Schilling, William F.", "descri"=>"Heatwole's Dairy Paper, Vol. I, No. 1, March 1906. Cover features a portrait of Prof. T.L. Harker, Minnesota's Greatest Dairyman. Main story is by Prof. L T. Haecker: \"\"Dairy Cow Rations, Economical Feeding for Milk Production.\"\"", "dat"=>"1906-03-01", "publia"=>"Joel P. Heatwole (Northfield, Minnesota)", "dimens"=>{}, "genera"=>"Agriculture", "type"=>"Text", "physic"=>"Magazines (periodicals)", "specif"=>"Agricultural education; Dairy farming; Dairy products industry;", "subjec"=>"Agriculture", "city"=>"Northfield", "distri"=>{}, "county"=>"Rice", "state"=>"Minnesota", "countr"=>"United States", "geogra"=>{}, "latitu"=>{}, "longit"=>{}, "geogrb"=>{}, "langua"=>"English", "par"=>{}, "contra"=>"Northfield Historical Society", "contac"=>"Northfield Historical Society, 408 Division Street, Northfield, Minnesota 55057", "righta"=>"Use of this object is governed by U.S. and international copyright law. Contact the Northfield Historical Society for permission to use this object.", "identi"=>"86-25-1-1906-03-v1-n01", "resour"=>{}, "projec"=>"Minnesota Reflections 2012-13;", "fiscal"=>"Funding provided to the Minnesota Digital Library through the Minnesota Arts and Cultural Heritage Fund, a component of the Minnesota Clean Water, Land and Legacy constitutional amendment, ratified by Minnesota voters in 2008.", "publis"=>{}, "date"=>{}, "format"=>{}, "digspe"=>{}, "digspa"=>{}, "digspb"=>{}, "digspc"=>{}, "digspd"=>{}, "digspf"=>{}, "digspg"=>{}, "digsph"=>{}, "digspi"=>{}, "digspj"=>{}, "digspk"=>{}, "transc"=>{}, "transl"=>{}, "fullrs"=>{}, "find"=>"131.cpd", "dmaccess"=>{}, "dmimage"=>{}, "dmcreated"=>"2014-03-11", "dmmodified"=>"2014-03-11", "dmoclcno"=>{}, "dmrecord"=>"359", "restrictionCode"=>"1", "cdmfilesize"=>"2353", "cdmfilesizeformatted"=>"0.00 MB", "cdmprintpdf"=>"0", "cdmhasocr"=>"0", "cdmisnewspaper"=>"0", :id=>"nfh:359", :compound_objects=>[{"pagetitle"=>"Front cover", "pagefile"=>"112.jp2", "pageptr"=>"340", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=340&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Inside front cover", "pagefile"=>"113.jp2", "pageptr"=>"341", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=341&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 1", "pagefile"=>"114.jp2", "pageptr"=>"342", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=342&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 2", "pagefile"=>"115.jp2", "pageptr"=>"343", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=343&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 3", "pagefile"=>"116.jp2", "pageptr"=>"344", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=344&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 4", "pagefile"=>"117.jp2", "pageptr"=>"345", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=345&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 5", "pagefile"=>"118.jp2", "pageptr"=>"346", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=346&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 6", "pagefile"=>"119.jp2", "pageptr"=>"347", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=347&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 7", "pagefile"=>"120.jp2", "pageptr"=>"348", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=348&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 8", "pagefile"=>"121.jp2", "pageptr"=>"349", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=349&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 9", "pagefile"=>"122.jp2", "pageptr"=>"350", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=350&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 10", "pagefile"=>"123.jp2", "pageptr"=>"351", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=351&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 11", "pagefile"=>"124.jp2", "pageptr"=>"352", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=352&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 12", "pagefile"=>"125.jp2", "pageptr"=>"353", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=353&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 13", "pagefile"=>"126.jp2", "pageptr"=>"354", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=354&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 14", "pagefile"=>"127.jp2", "pageptr"=>"355", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=355&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 15", "pagefile"=>"128.jp2", "pageptr"=>"356", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=356&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 16", "pagefile"=>"129.jp2", "pageptr"=>"357", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=357&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Back cover", "pagefile"=>"130.jp2", "pageptr"=>"358", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=358&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}], :record_type=>"compound"}
    assert_equal expected, extractor.build_record(identifiers: {collection: 'nfh', identifier: 359})
  end

  def test_record_missing
    expected = {:status=>"Record Missing", :collection=>'nfh', :id=>666666}
    assert_equal expected, extractor.build_record(identifiers: {collection: 'nfh', identifier:  666666})
  end

  def test_record_and_collection_missing
    expected = {:status=>"Record Missing", :collection=>"yeehaw_shakespeare", :id=>666666}
    assert_equal expected, extractor.build_record(identifiers: {collection: 'yeehaw_shakespeare', identifier:  666666})
  end

  def test_oai_deleted
    extractor = TinyEtl::ContentdmExtractor.new(args: {base_uri: base_uri}, state: {resumption_token: 'foo', data: [{deleted: true, :identifiers=>{collection: 'nemhc', identifier: 4080}}]})
    assert_equal [], extractor.state[:data]
    assert_equal 'foo', extractor.state[:resumption_token]
  end

  def test_get_compount_object_info_missing
    expected = %q[{"message":"Requested item is not compound","code":"-2"}]
    response = TinyEtl::ContentdmExtractor.new(args: {base_uri: base_uri}, state: {}).item_api_request('dmGetCompoundObjectInfo', 'yeehaw_shakespeare', 666)
    assert_equal "200", response.code # Really whish this was a not found
    assert_equal expected, response.body
  end

  def test_state
    expected = [{"title"=>"Heatwole's Dairy Paper, Volume I, Number 1, March 1906", "photog"=>{}, "contri"=>"Schilling, William F.", "descri"=>"Heatwole's Dairy Paper, Vol. I, No. 1, March 1906. Cover features a portrait of Prof. T.L. Harker, Minnesota's Greatest Dairyman. Main story is by Prof. L T. Haecker: \"\"Dairy Cow Rations, Economical Feeding for Milk Production.\"\"", "dat"=>"1906-03-01", "publia"=>"Joel P. Heatwole (Northfield, Minnesota)", "dimens"=>{}, "genera"=>"Agriculture", "type"=>"Text", "physic"=>"Magazines (periodicals)", "specif"=>"Agricultural education; Dairy farming; Dairy products industry;", "subjec"=>"Agriculture", "city"=>"Northfield", "distri"=>{}, "county"=>"Rice", "state"=>"Minnesota", "countr"=>"United States", "geogra"=>{}, "latitu"=>{}, "longit"=>{}, "geogrb"=>{}, "langua"=>"English", "par"=>{}, "contra"=>"Northfield Historical Society", "contac"=>"Northfield Historical Society, 408 Division Street, Northfield, Minnesota 55057", "righta"=>"Use of this object is governed by U.S. and international copyright law. Contact the Northfield Historical Society for permission to use this object.", "identi"=>"86-25-1-1906-03-v1-n01", "resour"=>{}, "projec"=>"Minnesota Reflections 2012-13;", "fiscal"=>"Funding provided to the Minnesota Digital Library through the Minnesota Arts and Cultural Heritage Fund, a component of the Minnesota Clean Water, Land and Legacy constitutional amendment, ratified by Minnesota voters in 2008.", "publis"=>{}, "date"=>{}, "format"=>{}, "digspe"=>{}, "digspa"=>{}, "digspb"=>{}, "digspc"=>{}, "digspd"=>{}, "digspf"=>{}, "digspg"=>{}, "digsph"=>{}, "digspi"=>{}, "digspj"=>{}, "digspk"=>{}, "transc"=>{}, "transl"=>{}, "fullrs"=>{}, "find"=>"131.cpd", "dmaccess"=>{}, "dmimage"=>{}, "dmcreated"=>"2014-03-11", "dmmodified"=>"2014-03-11", "dmoclcno"=>{}, "dmrecord"=>"359", "restrictionCode"=>"1", "cdmfilesize"=>"2353", "cdmfilesizeformatted"=>"0.00 MB", "cdmprintpdf"=>"0", "cdmhasocr"=>"0", "cdmisnewspaper"=>"0", :id=>"nfh:359", :compound_objects=>[{"pagetitle"=>"Front cover", "pagefile"=>"112.jp2", "pageptr"=>"340", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=340&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Inside front cover", "pagefile"=>"113.jp2", "pageptr"=>"341", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=341&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 1", "pagefile"=>"114.jp2", "pageptr"=>"342", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=342&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 2", "pagefile"=>"115.jp2", "pageptr"=>"343", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=343&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 3", "pagefile"=>"116.jp2", "pageptr"=>"344", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=344&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 4", "pagefile"=>"117.jp2", "pageptr"=>"345", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=345&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 5", "pagefile"=>"118.jp2", "pageptr"=>"346", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=346&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 6", "pagefile"=>"119.jp2", "pageptr"=>"347", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=347&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 7", "pagefile"=>"120.jp2", "pageptr"=>"348", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=348&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 8", "pagefile"=>"121.jp2", "pageptr"=>"349", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=349&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 9", "pagefile"=>"122.jp2", "pageptr"=>"350", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=350&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 10", "pagefile"=>"123.jp2", "pageptr"=>"351", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=351&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 11", "pagefile"=>"124.jp2", "pageptr"=>"352", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=352&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 12", "pagefile"=>"125.jp2", "pageptr"=>"353", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=353&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 13", "pagefile"=>"126.jp2", "pageptr"=>"354", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=354&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 14", "pagefile"=>"127.jp2", "pageptr"=>"355", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=355&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 15", "pagefile"=>"128.jp2", "pageptr"=>"356", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=356&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Page 16", "pagefile"=>"129.jp2", "pageptr"=>"357", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=357&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}, {"pagetitle"=>"Back cover", "pagefile"=>"130.jp2", "pageptr"=>"358", :image_uri=>"https://server16022.contentdm.oclc.org/dmwebservices/index.php/utils/ajaxhelper/?CISOROOT=nfh&CISOPTR=358&action=2&DMSCALE=100&DMWIDTH=10000&DMHEIGHT=10000"}], :record_type=>"compound"}]
    extractor = TinyEtl::ContentdmExtractor.new(args: {base_uri: base_uri}, state: {resumption_token: 'foo', data: [{:identifiers=>{:collection=>"nfh", :identifier=>359}}]})
    assert_equal expected, extractor.state[:data]
    assert_equal 'foo', extractor.state[:resumption_token]
  end
end
