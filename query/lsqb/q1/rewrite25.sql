## AggReduce Phase: 

# AggReduce225
# 1. aggView
create or replace view aggView9170300279866174984 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin963558878371692651 as select CityId as v6, annot from City as City, aggView9170300279866174984 where City.isPartOf_CountryId=aggView9170300279866174984.v4;

# AggReduce226
# 1. aggView
create or replace view aggView8982661211766613680 as select v6, SUM(annot) as annot from aggJoin963558878371692651 group by v6;
# 2. aggJoin
create or replace view aggJoin6208607477712460051 as select PersonId as v8, annot from Person as Person, aggView8982661211766613680 where Person.isLocatedIn_CityId=aggView8982661211766613680.v6;

# AggReduce227
# 1. aggView
create or replace view aggView3101796864541713768 as select v8, SUM(annot) as annot from aggJoin6208607477712460051 group by v8;
# 2. aggJoin
create or replace view aggJoin3791337420825873490 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView3101796864541713768 where Forum_hasMember_Person.PersonId=aggView3101796864541713768.v8;

# AggReduce228
# 1. aggView
create or replace view aggView2964834708062983562 as select v9, SUM(annot) as annot from aggJoin3791337420825873490 group by v9;
# 2. aggJoin
create or replace view aggJoin6796564158061718030 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView2964834708062983562 where Post.Forum_containerOfId=aggView2964834708062983562.v9;

# AggReduce229
# 1. aggView
create or replace view aggView6621892069125251264 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin8494932119882518837 as select v18, aggJoin6796564158061718030.annot * aggView6621892069125251264.annot as annot from aggJoin6796564158061718030 join aggView6621892069125251264 using(v9);

# AggReduce230
# 1. aggView
create or replace view aggView1585600275836898724 as select v18, SUM(annot) as annot from aggJoin8494932119882518837 group by v18;
# 2. aggJoin
create or replace view aggJoin8634961478649559750 as select CommentId as v20, annot from Comment as Comment, aggView1585600275836898724 where Comment.replyOf_PostId=aggView1585600275836898724.v18;

# AggReduce231
# 1. aggView
create or replace view aggView393192915750576814 as select v20, SUM(annot) as annot from aggJoin8634961478649559750 group by v20;
# 2. aggJoin
create or replace view aggJoin6350927138900970614 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView393192915750576814 where Comment_hasTag_Tag.CommentId=aggView393192915750576814.v20;

# AggReduce232
# 1. aggView
create or replace view aggView5148543222855350576 as select v22, SUM(annot) as annot from aggJoin6350927138900970614 group by v22;
# 2. aggJoin
create or replace view aggJoin7679652640882622037 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView5148543222855350576 where Tag.TagId=aggView5148543222855350576.v22;

# AggReduce233
# 1. aggView
create or replace view aggView7186449597731637127 as select v23, SUM(annot) as annot from aggJoin7679652640882622037 group by v23;
# 2. aggJoin
create or replace view aggJoin6599037844310164528 as select annot from TagClass as TagClass, aggView7186449597731637127 where TagClass.TagClassId=aggView7186449597731637127.v23;
# Final result: 
select SUM(annot) as v26 from aggJoin6599037844310164528;

# drop view aggView9170300279866174984, aggJoin963558878371692651, aggView8982661211766613680, aggJoin6208607477712460051, aggView3101796864541713768, aggJoin3791337420825873490, aggView2964834708062983562, aggJoin6796564158061718030, aggView6621892069125251264, aggJoin8494932119882518837, aggView1585600275836898724, aggJoin8634961478649559750, aggView393192915750576814, aggJoin6350927138900970614, aggView5148543222855350576, aggJoin7679652640882622037, aggView7186449597731637127, aggJoin6599037844310164528;
