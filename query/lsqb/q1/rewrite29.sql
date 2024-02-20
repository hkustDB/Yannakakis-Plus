## AggReduce Phase: 

# AggReduce261
# 1. aggView
create or replace view aggView656568837158222808 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin5831532202132355715 as select CityId as v6, annot from City as City, aggView656568837158222808 where City.isPartOf_CountryId=aggView656568837158222808.v4;

# AggReduce262
# 1. aggView
create or replace view aggView6020620449523586660 as select v6, SUM(annot) as annot from aggJoin5831532202132355715 group by v6;
# 2. aggJoin
create or replace view aggJoin8436822798913958621 as select PersonId as v8, annot from Person as Person, aggView6020620449523586660 where Person.isLocatedIn_CityId=aggView6020620449523586660.v6;

# AggReduce263
# 1. aggView
create or replace view aggView8437496659902804378 as select v8, SUM(annot) as annot from aggJoin8436822798913958621 group by v8;
# 2. aggJoin
create or replace view aggJoin1117015737318676892 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView8437496659902804378 where Forum_hasMember_Person.PersonId=aggView8437496659902804378.v8;

# AggReduce264
# 1. aggView
create or replace view aggView1852919602666618274 as select v9, SUM(annot) as annot from aggJoin1117015737318676892 group by v9;
# 2. aggJoin
create or replace view aggJoin7683452930666345357 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView1852919602666618274 where Post.Forum_containerOfId=aggView1852919602666618274.v9;

# AggReduce265
# 1. aggView
create or replace view aggView6466605294126843872 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin6719646033507108395 as select TagId as v22, annot from Tag as Tag, aggView6466605294126843872 where Tag.hasType_TagClassId=aggView6466605294126843872.v23;

# AggReduce266
# 1. aggView
create or replace view aggView4731287113057029484 as select v22, SUM(annot) as annot from aggJoin6719646033507108395 group by v22;
# 2. aggJoin
create or replace view aggJoin3747166069490678994 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView4731287113057029484 where Comment_hasTag_Tag.TagId=aggView4731287113057029484.v22;

# AggReduce267
# 1. aggView
create or replace view aggView6332335358621640243 as select v20, SUM(annot) as annot from aggJoin3747166069490678994 group by v20;
# 2. aggJoin
create or replace view aggJoin9152471092738699433 as select replyOf_PostId as v18, annot from Comment as Comment, aggView6332335358621640243 where Comment.CommentId=aggView6332335358621640243.v20;

# AggReduce268
# 1. aggView
create or replace view aggView6441644898050336319 as select v18, SUM(annot) as annot from aggJoin9152471092738699433 group by v18;
# 2. aggJoin
create or replace view aggJoin1763561141055432815 as select v9, aggJoin7683452930666345357.annot * aggView6441644898050336319.annot as annot from aggJoin7683452930666345357 join aggView6441644898050336319 using(v18);

# AggReduce269
# 1. aggView
create or replace view aggView2613142651331821046 as select v9, SUM(annot) as annot from aggJoin1763561141055432815 group by v9;
# 2. aggJoin
create or replace view aggJoin7693708704883574453 as select annot from Forum as Forum, aggView2613142651331821046 where Forum.ForumId=aggView2613142651331821046.v9;
# Final result: 
select SUM(annot) as v26 from aggJoin7693708704883574453;

# drop view aggView656568837158222808, aggJoin5831532202132355715, aggView6020620449523586660, aggJoin8436822798913958621, aggView8437496659902804378, aggJoin1117015737318676892, aggView1852919602666618274, aggJoin7683452930666345357, aggView6466605294126843872, aggJoin6719646033507108395, aggView4731287113057029484, aggJoin3747166069490678994, aggView6332335358621640243, aggJoin9152471092738699433, aggView6441644898050336319, aggJoin1763561141055432815, aggView2613142651331821046, aggJoin7693708704883574453;
