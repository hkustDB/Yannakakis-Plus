## AggReduce Phase: 

# AggReduce81
# 1. aggView
create or replace view aggView3799205108216471826 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin7056108928346701399 as select CityId as v6, annot from City as City, aggView3799205108216471826 where City.isPartOf_CountryId=aggView3799205108216471826.v4;

# AggReduce82
# 1. aggView
create or replace view aggView7332186588684295528 as select v6, SUM(annot) as annot from aggJoin7056108928346701399 group by v6;
# 2. aggJoin
create or replace view aggJoin1847306954444739214 as select PersonId as v8, annot from Person as Person, aggView7332186588684295528 where Person.isLocatedIn_CityId=aggView7332186588684295528.v6;

# AggReduce83
# 1. aggView
create or replace view aggView1981102880552103251 as select v8, SUM(annot) as annot from aggJoin1847306954444739214 group by v8;
# 2. aggJoin
create or replace view aggJoin8435224012898814652 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView1981102880552103251 where Forum_hasMember_Person.PersonId=aggView1981102880552103251.v8;

# AggReduce84
# 1. aggView
create or replace view aggView7900151743368529297 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin6116900839238529050 as select TagId as v22, annot from Tag as Tag, aggView7900151743368529297 where Tag.hasType_TagClassId=aggView7900151743368529297.v23;

# AggReduce85
# 1. aggView
create or replace view aggView3066314231618686981 as select v22, SUM(annot) as annot from aggJoin6116900839238529050 group by v22;
# 2. aggJoin
create or replace view aggJoin9076936938124375480 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView3066314231618686981 where Comment_hasTag_Tag.TagId=aggView3066314231618686981.v22;

# AggReduce86
# 1. aggView
create or replace view aggView3913458347621414148 as select v20, SUM(annot) as annot from aggJoin9076936938124375480 group by v20;
# 2. aggJoin
create or replace view aggJoin1020008981313279489 as select replyOf_PostId as v18, annot from Comment as Comment, aggView3913458347621414148 where Comment.CommentId=aggView3913458347621414148.v20;

# AggReduce87
# 1. aggView
create or replace view aggView1818259029955054784 as select v18, SUM(annot) as annot from aggJoin1020008981313279489 group by v18;
# 2. aggJoin
create or replace view aggJoin3416346455128970857 as select Forum_containerOfId as v9, annot from Post as Post, aggView1818259029955054784 where Post.PostId=aggView1818259029955054784.v18;

# AggReduce88
# 1. aggView
create or replace view aggView2981075329779004656 as select v9, SUM(annot) as annot from aggJoin3416346455128970857 group by v9;
# 2. aggJoin
create or replace view aggJoin3493886091369459375 as select v9, aggJoin8435224012898814652.annot * aggView2981075329779004656.annot as annot from aggJoin8435224012898814652 join aggView2981075329779004656 using(v9);

# AggReduce89
# 1. aggView
create or replace view aggView2738734465526908094 as select v9, SUM(annot) as annot from aggJoin3493886091369459375 group by v9;
# 2. aggJoin
create or replace view aggJoin7272023042966882184 as select annot from Forum as Forum, aggView2738734465526908094 where Forum.ForumId=aggView2738734465526908094.v9;
# Final result: 
select SUM(annot) as v26 from aggJoin7272023042966882184;

# drop view aggView3799205108216471826, aggJoin7056108928346701399, aggView7332186588684295528, aggJoin1847306954444739214, aggView1981102880552103251, aggJoin8435224012898814652, aggView7900151743368529297, aggJoin6116900839238529050, aggView3066314231618686981, aggJoin9076936938124375480, aggView3913458347621414148, aggJoin1020008981313279489, aggView1818259029955054784, aggJoin3416346455128970857, aggView2981075329779004656, aggJoin3493886091369459375, aggView2738734465526908094, aggJoin7272023042966882184;
