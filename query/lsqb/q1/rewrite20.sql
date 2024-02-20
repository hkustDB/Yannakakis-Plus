## AggReduce Phase: 

# AggReduce180
# 1. aggView
create or replace view aggView2328945765251274705 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin6067742726179899440 as select CityId as v6, annot from City as City, aggView2328945765251274705 where City.isPartOf_CountryId=aggView2328945765251274705.v4;

# AggReduce181
# 1. aggView
create or replace view aggView3651630218300384638 as select v6, SUM(annot) as annot from aggJoin6067742726179899440 group by v6;
# 2. aggJoin
create or replace view aggJoin1646041761365363466 as select PersonId as v8, annot from Person as Person, aggView3651630218300384638 where Person.isLocatedIn_CityId=aggView3651630218300384638.v6;

# AggReduce182
# 1. aggView
create or replace view aggView6991985327063030126 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin2532739370281055571 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView6991985327063030126 where Post.Forum_containerOfId=aggView6991985327063030126.v9;

# AggReduce183
# 1. aggView
create or replace view aggView343486175182343971 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin8603805361077679222 as select TagId as v22, annot from Tag as Tag, aggView343486175182343971 where Tag.hasType_TagClassId=aggView343486175182343971.v23;

# AggReduce184
# 1. aggView
create or replace view aggView7585639294320657568 as select v22, SUM(annot) as annot from aggJoin8603805361077679222 group by v22;
# 2. aggJoin
create or replace view aggJoin4050297906141089188 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView7585639294320657568 where Comment_hasTag_Tag.TagId=aggView7585639294320657568.v22;

# AggReduce185
# 1. aggView
create or replace view aggView428786659989301143 as select v20, SUM(annot) as annot from aggJoin4050297906141089188 group by v20;
# 2. aggJoin
create or replace view aggJoin3177146727023534315 as select replyOf_PostId as v18, annot from Comment as Comment, aggView428786659989301143 where Comment.CommentId=aggView428786659989301143.v20;

# AggReduce186
# 1. aggView
create or replace view aggView7093896901600873719 as select v18, SUM(annot) as annot from aggJoin3177146727023534315 group by v18;
# 2. aggJoin
create or replace view aggJoin1591690600639179271 as select v9, aggJoin2532739370281055571.annot * aggView7093896901600873719.annot as annot from aggJoin2532739370281055571 join aggView7093896901600873719 using(v18);

# AggReduce187
# 1. aggView
create or replace view aggView7444165118713264562 as select v9, SUM(annot) as annot from aggJoin1591690600639179271 group by v9;
# 2. aggJoin
create or replace view aggJoin1117020940040242583 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView7444165118713264562 where Forum_hasMember_Person.ForumId=aggView7444165118713264562.v9;

# AggReduce188
# 1. aggView
create or replace view aggView9154625487242449877 as select v8, SUM(annot) as annot from aggJoin1117020940040242583 group by v8;
# 2. aggJoin
create or replace view aggJoin653636093877011454 as select aggJoin1646041761365363466.annot * aggView9154625487242449877.annot as annot from aggJoin1646041761365363466 join aggView9154625487242449877 using(v8);
# Final result: 
select SUM(annot) as v26 from aggJoin653636093877011454;

# drop view aggView2328945765251274705, aggJoin6067742726179899440, aggView3651630218300384638, aggJoin1646041761365363466, aggView6991985327063030126, aggJoin2532739370281055571, aggView343486175182343971, aggJoin8603805361077679222, aggView7585639294320657568, aggJoin4050297906141089188, aggView428786659989301143, aggJoin3177146727023534315, aggView7093896901600873719, aggJoin1591690600639179271, aggView7444165118713264562, aggJoin1117020940040242583, aggView9154625487242449877, aggJoin653636093877011454;
