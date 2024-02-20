## AggReduce Phase: 

# AggReduce144
# 1. aggView
create or replace view aggView6248249790247804649 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin9003447701392817780 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6248249790247804649 where Forum_hasMember_Person.ForumId=aggView6248249790247804649.v9;

# AggReduce145
# 1. aggView
create or replace view aggView4037638235086762236 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin6373135214161695312 as select CityId as v6, annot from City as City, aggView4037638235086762236 where City.isPartOf_CountryId=aggView4037638235086762236.v4;

# AggReduce146
# 1. aggView
create or replace view aggView4600973176895726750 as select v6, SUM(annot) as annot from aggJoin6373135214161695312 group by v6;
# 2. aggJoin
create or replace view aggJoin4654708473657311077 as select PersonId as v8, annot from Person as Person, aggView4600973176895726750 where Person.isLocatedIn_CityId=aggView4600973176895726750.v6;

# AggReduce147
# 1. aggView
create or replace view aggView5984931728522244906 as select v8, SUM(annot) as annot from aggJoin4654708473657311077 group by v8;
# 2. aggJoin
create or replace view aggJoin8250971833487045215 as select v9, aggJoin9003447701392817780.annot * aggView5984931728522244906.annot as annot from aggJoin9003447701392817780 join aggView5984931728522244906 using(v8);

# AggReduce148
# 1. aggView
create or replace view aggView1043465221059981710 as select v9, SUM(annot) as annot from aggJoin8250971833487045215 group by v9;
# 2. aggJoin
create or replace view aggJoin1257610421387097167 as select PostId as v18, annot from Post as Post, aggView1043465221059981710 where Post.Forum_containerOfId=aggView1043465221059981710.v9;

# AggReduce149
# 1. aggView
create or replace view aggView7643516826628111765 as select v18, SUM(annot) as annot from aggJoin1257610421387097167 group by v18;
# 2. aggJoin
create or replace view aggJoin4251681654552337593 as select CommentId as v20, annot from Comment as Comment, aggView7643516826628111765 where Comment.replyOf_PostId=aggView7643516826628111765.v18;

# AggReduce150
# 1. aggView
create or replace view aggView6829042987414862235 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin4704346097405523170 as select TagId as v22, annot from Tag as Tag, aggView6829042987414862235 where Tag.hasType_TagClassId=aggView6829042987414862235.v23;

# AggReduce151
# 1. aggView
create or replace view aggView3557511213004950314 as select v22, SUM(annot) as annot from aggJoin4704346097405523170 group by v22;
# 2. aggJoin
create or replace view aggJoin2525842993526490543 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView3557511213004950314 where Comment_hasTag_Tag.TagId=aggView3557511213004950314.v22;

# AggReduce152
# 1. aggView
create or replace view aggView7981394472137176909 as select v20, SUM(annot) as annot from aggJoin2525842993526490543 group by v20;
# 2. aggJoin
create or replace view aggJoin1433852092224628451 as select aggJoin4251681654552337593.annot * aggView7981394472137176909.annot as annot from aggJoin4251681654552337593 join aggView7981394472137176909 using(v20);
# Final result: 
select SUM(annot) as v26 from aggJoin1433852092224628451;

# drop view aggView6248249790247804649, aggJoin9003447701392817780, aggView4037638235086762236, aggJoin6373135214161695312, aggView4600973176895726750, aggJoin4654708473657311077, aggView5984931728522244906, aggJoin8250971833487045215, aggView1043465221059981710, aggJoin1257610421387097167, aggView7643516826628111765, aggJoin4251681654552337593, aggView6829042987414862235, aggJoin4704346097405523170, aggView3557511213004950314, aggJoin2525842993526490543, aggView7981394472137176909, aggJoin1433852092224628451;
