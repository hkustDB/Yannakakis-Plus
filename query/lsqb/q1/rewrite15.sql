## AggReduce Phase: 

# AggReduce135
# 1. aggView
create or replace view aggView4315123115504392057 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin7820180009535585609 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView4315123115504392057 where Forum_hasMember_Person.ForumId=aggView4315123115504392057.v9;

# AggReduce136
# 1. aggView
create or replace view aggView6377915257793463441 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin2275115952129405551 as select CityId as v6, annot from City as City, aggView6377915257793463441 where City.isPartOf_CountryId=aggView6377915257793463441.v4;

# AggReduce137
# 1. aggView
create or replace view aggView8526051848984163875 as select v6, SUM(annot) as annot from aggJoin2275115952129405551 group by v6;
# 2. aggJoin
create or replace view aggJoin2921556906010107500 as select PersonId as v8, annot from Person as Person, aggView8526051848984163875 where Person.isLocatedIn_CityId=aggView8526051848984163875.v6;

# AggReduce138
# 1. aggView
create or replace view aggView1760455113319928376 as select v8, SUM(annot) as annot from aggJoin2921556906010107500 group by v8;
# 2. aggJoin
create or replace view aggJoin392198436404427681 as select v9, aggJoin7820180009535585609.annot * aggView1760455113319928376.annot as annot from aggJoin7820180009535585609 join aggView1760455113319928376 using(v8);

# AggReduce139
# 1. aggView
create or replace view aggView5789535854313384814 as select v9, SUM(annot) as annot from aggJoin392198436404427681 group by v9;
# 2. aggJoin
create or replace view aggJoin7547079665556587180 as select PostId as v18, annot from Post as Post, aggView5789535854313384814 where Post.Forum_containerOfId=aggView5789535854313384814.v9;

# AggReduce140
# 1. aggView
create or replace view aggView2258251202637535272 as select v18, SUM(annot) as annot from aggJoin7547079665556587180 group by v18;
# 2. aggJoin
create or replace view aggJoin921564675924628823 as select CommentId as v20, annot from Comment as Comment, aggView2258251202637535272 where Comment.replyOf_PostId=aggView2258251202637535272.v18;

# AggReduce141
# 1. aggView
create or replace view aggView525969247182882892 as select v20, SUM(annot) as annot from aggJoin921564675924628823 group by v20;
# 2. aggJoin
create or replace view aggJoin5509997115007946110 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView525969247182882892 where Comment_hasTag_Tag.CommentId=aggView525969247182882892.v20;

# AggReduce142
# 1. aggView
create or replace view aggView1092847561185486018 as select v22, SUM(annot) as annot from aggJoin5509997115007946110 group by v22;
# 2. aggJoin
create or replace view aggJoin773660436456308736 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView1092847561185486018 where Tag.TagId=aggView1092847561185486018.v22;

# AggReduce143
# 1. aggView
create or replace view aggView7970166965410569447 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin7680419315699920803 as select aggJoin773660436456308736.annot * aggView7970166965410569447.annot as annot from aggJoin773660436456308736 join aggView7970166965410569447 using(v23);
# Final result: 
select SUM(annot) as v26 from aggJoin7680419315699920803;

# drop view aggView4315123115504392057, aggJoin7820180009535585609, aggView6377915257793463441, aggJoin2275115952129405551, aggView8526051848984163875, aggJoin2921556906010107500, aggView1760455113319928376, aggJoin392198436404427681, aggView5789535854313384814, aggJoin7547079665556587180, aggView2258251202637535272, aggJoin921564675924628823, aggView525969247182882892, aggJoin5509997115007946110, aggView1092847561185486018, aggJoin773660436456308736, aggView7970166965410569447, aggJoin7680419315699920803;
