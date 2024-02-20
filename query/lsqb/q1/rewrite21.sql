## AggReduce Phase: 

# AggReduce189
# 1. aggView
create or replace view aggView5911811357575964223 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin3480497138843106864 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView5911811357575964223 where Forum_hasMember_Person.ForumId=aggView5911811357575964223.v9;

# AggReduce190
# 1. aggView
create or replace view aggView6533500753258172233 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin3402422457987946200 as select CityId as v6, annot from City as City, aggView6533500753258172233 where City.isPartOf_CountryId=aggView6533500753258172233.v4;

# AggReduce191
# 1. aggView
create or replace view aggView696874305013582915 as select v6, SUM(annot) as annot from aggJoin3402422457987946200 group by v6;
# 2. aggJoin
create or replace view aggJoin6627068815432882285 as select PersonId as v8, annot from Person as Person, aggView696874305013582915 where Person.isLocatedIn_CityId=aggView696874305013582915.v6;

# AggReduce192
# 1. aggView
create or replace view aggView5830422480963440891 as select v8, SUM(annot) as annot from aggJoin6627068815432882285 group by v8;
# 2. aggJoin
create or replace view aggJoin5350857530382873167 as select v9, aggJoin3480497138843106864.annot * aggView5830422480963440891.annot as annot from aggJoin3480497138843106864 join aggView5830422480963440891 using(v8);

# AggReduce193
# 1. aggView
create or replace view aggView9011674700636579469 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin990904411902091226 as select TagId as v22, annot from Tag as Tag, aggView9011674700636579469 where Tag.hasType_TagClassId=aggView9011674700636579469.v23;

# AggReduce194
# 1. aggView
create or replace view aggView2209690250218639643 as select v22, SUM(annot) as annot from aggJoin990904411902091226 group by v22;
# 2. aggJoin
create or replace view aggJoin6139700919756366262 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView2209690250218639643 where Comment_hasTag_Tag.TagId=aggView2209690250218639643.v22;

# AggReduce195
# 1. aggView
create or replace view aggView2328288517850730180 as select v20, SUM(annot) as annot from aggJoin6139700919756366262 group by v20;
# 2. aggJoin
create or replace view aggJoin8788736678773207534 as select replyOf_PostId as v18, annot from Comment as Comment, aggView2328288517850730180 where Comment.CommentId=aggView2328288517850730180.v20;

# AggReduce196
# 1. aggView
create or replace view aggView4381165100117452510 as select v18, SUM(annot) as annot from aggJoin8788736678773207534 group by v18;
# 2. aggJoin
create or replace view aggJoin1154896298748548307 as select Forum_containerOfId as v9, annot from Post as Post, aggView4381165100117452510 where Post.PostId=aggView4381165100117452510.v18;

# AggReduce197
# 1. aggView
create or replace view aggView4462541381164878384 as select v9, SUM(annot) as annot from aggJoin1154896298748548307 group by v9;
# 2. aggJoin
create or replace view aggJoin6107820061374055656 as select aggJoin5350857530382873167.annot * aggView4462541381164878384.annot as annot from aggJoin5350857530382873167 join aggView4462541381164878384 using(v9);
# Final result: 
select SUM(annot) as v26 from aggJoin6107820061374055656;

# drop view aggView5911811357575964223, aggJoin3480497138843106864, aggView6533500753258172233, aggJoin3402422457987946200, aggView696874305013582915, aggJoin6627068815432882285, aggView5830422480963440891, aggJoin5350857530382873167, aggView9011674700636579469, aggJoin990904411902091226, aggView2209690250218639643, aggJoin6139700919756366262, aggView2328288517850730180, aggJoin8788736678773207534, aggView4381165100117452510, aggJoin1154896298748548307, aggView4462541381164878384, aggJoin6107820061374055656;
