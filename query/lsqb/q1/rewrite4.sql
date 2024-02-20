## AggReduce Phase: 

# AggReduce36
# 1. aggView
create or replace view aggView2794292605613746031 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin1217815338068019012 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView2794292605613746031 where Forum_hasMember_Person.ForumId=aggView2794292605613746031.v9;

# AggReduce37
# 1. aggView
create or replace view aggView7546182677849754155 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin7892132023005414335 as select CityId as v6, annot from City as City, aggView7546182677849754155 where City.isPartOf_CountryId=aggView7546182677849754155.v4;

# AggReduce38
# 1. aggView
create or replace view aggView21856360354659876 as select v6, SUM(annot) as annot from aggJoin7892132023005414335 group by v6;
# 2. aggJoin
create or replace view aggJoin1713829862886205533 as select PersonId as v8, annot from Person as Person, aggView21856360354659876 where Person.isLocatedIn_CityId=aggView21856360354659876.v6;

# AggReduce39
# 1. aggView
create or replace view aggView1141472366577074088 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin1487081367149691032 as select TagId as v22, annot from Tag as Tag, aggView1141472366577074088 where Tag.hasType_TagClassId=aggView1141472366577074088.v23;

# AggReduce40
# 1. aggView
create or replace view aggView1573623853449216425 as select v22, SUM(annot) as annot from aggJoin1487081367149691032 group by v22;
# 2. aggJoin
create or replace view aggJoin8217796556009072907 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView1573623853449216425 where Comment_hasTag_Tag.TagId=aggView1573623853449216425.v22;

# AggReduce41
# 1. aggView
create or replace view aggView402580279798724949 as select v20, SUM(annot) as annot from aggJoin8217796556009072907 group by v20;
# 2. aggJoin
create or replace view aggJoin1050745676473743731 as select replyOf_PostId as v18, annot from Comment as Comment, aggView402580279798724949 where Comment.CommentId=aggView402580279798724949.v20;

# AggReduce42
# 1. aggView
create or replace view aggView7680419436546590977 as select v18, SUM(annot) as annot from aggJoin1050745676473743731 group by v18;
# 2. aggJoin
create or replace view aggJoin2897783427176460254 as select Forum_containerOfId as v9, annot from Post as Post, aggView7680419436546590977 where Post.PostId=aggView7680419436546590977.v18;

# AggReduce43
# 1. aggView
create or replace view aggView4202050390414755563 as select v9, SUM(annot) as annot from aggJoin2897783427176460254 group by v9;
# 2. aggJoin
create or replace view aggJoin9222682922851671547 as select v8, aggJoin1217815338068019012.annot * aggView4202050390414755563.annot as annot from aggJoin1217815338068019012 join aggView4202050390414755563 using(v9);

# AggReduce44
# 1. aggView
create or replace view aggView3289831023543443446 as select v8, SUM(annot) as annot from aggJoin9222682922851671547 group by v8;
# 2. aggJoin
create or replace view aggJoin7293020900340998648 as select aggJoin1713829862886205533.annot * aggView3289831023543443446.annot as annot from aggJoin1713829862886205533 join aggView3289831023543443446 using(v8);
# Final result: 
select SUM(annot) as v26 from aggJoin7293020900340998648;

# drop view aggView2794292605613746031, aggJoin1217815338068019012, aggView7546182677849754155, aggJoin7892132023005414335, aggView21856360354659876, aggJoin1713829862886205533, aggView1141472366577074088, aggJoin1487081367149691032, aggView1573623853449216425, aggJoin8217796556009072907, aggView402580279798724949, aggJoin1050745676473743731, aggView7680419436546590977, aggJoin2897783427176460254, aggView4202050390414755563, aggJoin9222682922851671547, aggView3289831023543443446, aggJoin7293020900340998648;
