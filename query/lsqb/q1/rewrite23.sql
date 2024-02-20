## AggReduce Phase: 

# AggReduce207
# 1. aggView
create or replace view aggView107775832502632326 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin7405931661986374478 as select CityId as v6, annot from City as City, aggView107775832502632326 where City.isPartOf_CountryId=aggView107775832502632326.v4;

# AggReduce208
# 1. aggView
create or replace view aggView1173227991173903387 as select v6, SUM(annot) as annot from aggJoin7405931661986374478 group by v6;
# 2. aggJoin
create or replace view aggJoin5464101281441681824 as select PersonId as v8, annot from Person as Person, aggView1173227991173903387 where Person.isLocatedIn_CityId=aggView1173227991173903387.v6;

# AggReduce209
# 1. aggView
create or replace view aggView5942449938068831595 as select v8, SUM(annot) as annot from aggJoin5464101281441681824 group by v8;
# 2. aggJoin
create or replace view aggJoin5121258658518270934 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView5942449938068831595 where Forum_hasMember_Person.PersonId=aggView5942449938068831595.v8;

# AggReduce210
# 1. aggView
create or replace view aggView46018208212905793 as select v9, SUM(annot) as annot from aggJoin5121258658518270934 group by v9;
# 2. aggJoin
create or replace view aggJoin8966845097148004634 as select ForumId as v9, annot from Forum as Forum, aggView46018208212905793 where Forum.ForumId=aggView46018208212905793.v9;

# AggReduce211
# 1. aggView
create or replace view aggView1468983648098632505 as select v9, SUM(annot) as annot from aggJoin8966845097148004634 group by v9;
# 2. aggJoin
create or replace view aggJoin7132736940525384206 as select PostId as v18, annot from Post as Post, aggView1468983648098632505 where Post.Forum_containerOfId=aggView1468983648098632505.v9;

# AggReduce212
# 1. aggView
create or replace view aggView7585518891086449076 as select v18, SUM(annot) as annot from aggJoin7132736940525384206 group by v18;
# 2. aggJoin
create or replace view aggJoin3883186416932319818 as select CommentId as v20, annot from Comment as Comment, aggView7585518891086449076 where Comment.replyOf_PostId=aggView7585518891086449076.v18;

# AggReduce213
# 1. aggView
create or replace view aggView6038297244530914792 as select v20, SUM(annot) as annot from aggJoin3883186416932319818 group by v20;
# 2. aggJoin
create or replace view aggJoin7916919345339061127 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView6038297244530914792 where Comment_hasTag_Tag.CommentId=aggView6038297244530914792.v20;

# AggReduce214
# 1. aggView
create or replace view aggView2495700240039269182 as select v22, SUM(annot) as annot from aggJoin7916919345339061127 group by v22;
# 2. aggJoin
create or replace view aggJoin4696106599549727037 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView2495700240039269182 where Tag.TagId=aggView2495700240039269182.v22;

# AggReduce215
# 1. aggView
create or replace view aggView3295954213925096715 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin5794101215253023848 as select aggJoin4696106599549727037.annot * aggView3295954213925096715.annot as annot from aggJoin4696106599549727037 join aggView3295954213925096715 using(v23);
# Final result: 
select SUM(annot) as v26 from aggJoin5794101215253023848;

# drop view aggView107775832502632326, aggJoin7405931661986374478, aggView1173227991173903387, aggJoin5464101281441681824, aggView5942449938068831595, aggJoin5121258658518270934, aggView46018208212905793, aggJoin8966845097148004634, aggView1468983648098632505, aggJoin7132736940525384206, aggView7585518891086449076, aggJoin3883186416932319818, aggView6038297244530914792, aggJoin7916919345339061127, aggView2495700240039269182, aggJoin4696106599549727037, aggView3295954213925096715, aggJoin5794101215253023848;
