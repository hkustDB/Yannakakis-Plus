## AggReduce Phase: 

# AggReduce27
# 1. aggView
create or replace view aggView3366151250378392423 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin4412957796980353091 as select CityId as v6, annot from City as City, aggView3366151250378392423 where City.isPartOf_CountryId=aggView3366151250378392423.v4;

# AggReduce28
# 1. aggView
create or replace view aggView262145852554860774 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin4529019600720793549 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView262145852554860774 where Post.Forum_containerOfId=aggView262145852554860774.v9;

# AggReduce29
# 1. aggView
create or replace view aggView1630057773598881200 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin7063492557299929958 as select TagId as v22, annot from Tag as Tag, aggView1630057773598881200 where Tag.hasType_TagClassId=aggView1630057773598881200.v23;

# AggReduce30
# 1. aggView
create or replace view aggView6624891923612843877 as select v22, SUM(annot) as annot from aggJoin7063492557299929958 group by v22;
# 2. aggJoin
create or replace view aggJoin683793073289723297 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView6624891923612843877 where Comment_hasTag_Tag.TagId=aggView6624891923612843877.v22;

# AggReduce31
# 1. aggView
create or replace view aggView8821356523362854839 as select v20, SUM(annot) as annot from aggJoin683793073289723297 group by v20;
# 2. aggJoin
create or replace view aggJoin6150273282079412537 as select replyOf_PostId as v18, annot from Comment as Comment, aggView8821356523362854839 where Comment.CommentId=aggView8821356523362854839.v20;

# AggReduce32
# 1. aggView
create or replace view aggView3950876401499659487 as select v18, SUM(annot) as annot from aggJoin6150273282079412537 group by v18;
# 2. aggJoin
create or replace view aggJoin219225428483747702 as select v9, aggJoin4529019600720793549.annot * aggView3950876401499659487.annot as annot from aggJoin4529019600720793549 join aggView3950876401499659487 using(v18);

# AggReduce33
# 1. aggView
create or replace view aggView7282501270984214880 as select v9, SUM(annot) as annot from aggJoin219225428483747702 group by v9;
# 2. aggJoin
create or replace view aggJoin817080836714343409 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView7282501270984214880 where Forum_hasMember_Person.ForumId=aggView7282501270984214880.v9;

# AggReduce34
# 1. aggView
create or replace view aggView6039970091151614159 as select v8, SUM(annot) as annot from aggJoin817080836714343409 group by v8;
# 2. aggJoin
create or replace view aggJoin8804083978352913658 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView6039970091151614159 where Person.PersonId=aggView6039970091151614159.v8;

# AggReduce35
# 1. aggView
create or replace view aggView3772560299047031309 as select v6, SUM(annot) as annot from aggJoin8804083978352913658 group by v6;
# 2. aggJoin
create or replace view aggJoin6947392844457338906 as select aggJoin4412957796980353091.annot * aggView3772560299047031309.annot as annot from aggJoin4412957796980353091 join aggView3772560299047031309 using(v6);
# Final result: 
select SUM(annot) as v26 from aggJoin6947392844457338906;

# drop view aggView3366151250378392423, aggJoin4412957796980353091, aggView262145852554860774, aggJoin4529019600720793549, aggView1630057773598881200, aggJoin7063492557299929958, aggView6624891923612843877, aggJoin683793073289723297, aggView8821356523362854839, aggJoin6150273282079412537, aggView3950876401499659487, aggJoin219225428483747702, aggView7282501270984214880, aggJoin817080836714343409, aggView6039970091151614159, aggJoin8804083978352913658, aggView3772560299047031309, aggJoin6947392844457338906;
