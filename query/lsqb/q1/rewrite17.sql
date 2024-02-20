## AggReduce Phase: 

# AggReduce153
# 1. aggView
create or replace view aggView571625122846101561 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin1246851744098520219 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView571625122846101561 where Forum_hasMember_Person.ForumId=aggView571625122846101561.v9;

# AggReduce154
# 1. aggView
create or replace view aggView4618749105037530278 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin9195627727731254624 as select CityId as v6, annot from City as City, aggView4618749105037530278 where City.isPartOf_CountryId=aggView4618749105037530278.v4;

# AggReduce155
# 1. aggView
create or replace view aggView6978249776724178617 as select v6, SUM(annot) as annot from aggJoin9195627727731254624 group by v6;
# 2. aggJoin
create or replace view aggJoin5208531246910063896 as select PersonId as v8, annot from Person as Person, aggView6978249776724178617 where Person.isLocatedIn_CityId=aggView6978249776724178617.v6;

# AggReduce156
# 1. aggView
create or replace view aggView6920488397332066605 as select v8, SUM(annot) as annot from aggJoin5208531246910063896 group by v8;
# 2. aggJoin
create or replace view aggJoin654435681349942042 as select v9, aggJoin1246851744098520219.annot * aggView6920488397332066605.annot as annot from aggJoin1246851744098520219 join aggView6920488397332066605 using(v8);

# AggReduce157
# 1. aggView
create or replace view aggView5679498434027425332 as select v9, SUM(annot) as annot from aggJoin654435681349942042 group by v9;
# 2. aggJoin
create or replace view aggJoin6137983571652215752 as select PostId as v18, annot from Post as Post, aggView5679498434027425332 where Post.Forum_containerOfId=aggView5679498434027425332.v9;

# AggReduce158
# 1. aggView
create or replace view aggView6141217828190868745 as select v18, SUM(annot) as annot from aggJoin6137983571652215752 group by v18;
# 2. aggJoin
create or replace view aggJoin6432567897655574955 as select CommentId as v20, annot from Comment as Comment, aggView6141217828190868745 where Comment.replyOf_PostId=aggView6141217828190868745.v18;

# AggReduce159
# 1. aggView
create or replace view aggView7059063007309533485 as select v20, SUM(annot) as annot from aggJoin6432567897655574955 group by v20;
# 2. aggJoin
create or replace view aggJoin7160742992912934415 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView7059063007309533485 where Comment_hasTag_Tag.CommentId=aggView7059063007309533485.v20;

# AggReduce160
# 1. aggView
create or replace view aggView7537603193778721641 as select v22, SUM(annot) as annot from aggJoin7160742992912934415 group by v22;
# 2. aggJoin
create or replace view aggJoin1311899282483253070 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView7537603193778721641 where Tag.TagId=aggView7537603193778721641.v22;

# AggReduce161
# 1. aggView
create or replace view aggView6637497646809833563 as select v23, SUM(annot) as annot from aggJoin1311899282483253070 group by v23;
# 2. aggJoin
create or replace view aggJoin3021968850868259380 as select annot from TagClass as TagClass, aggView6637497646809833563 where TagClass.TagClassId=aggView6637497646809833563.v23;
# Final result: 
select SUM(annot) as v26 from aggJoin3021968850868259380;

# drop view aggView571625122846101561, aggJoin1246851744098520219, aggView4618749105037530278, aggJoin9195627727731254624, aggView6978249776724178617, aggJoin5208531246910063896, aggView6920488397332066605, aggJoin654435681349942042, aggView5679498434027425332, aggJoin6137983571652215752, aggView6141217828190868745, aggJoin6432567897655574955, aggView7059063007309533485, aggJoin7160742992912934415, aggView7537603193778721641, aggJoin1311899282483253070, aggView6637497646809833563, aggJoin3021968850868259380;
