## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView482380879204014149 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin2764717098297434901 as select CityId as v6, annot from City as City, aggView482380879204014149 where City.isPartOf_CountryId=aggView482380879204014149.v4;

# AggReduce1
# 1. aggView
create or replace view aggView8585058616649138115 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin8256130774849626923 as select TagId as v22, annot from Tag as Tag, aggView8585058616649138115 where Tag.hasType_TagClassId=aggView8585058616649138115.v23;

# AggReduce2
# 1. aggView
create or replace view aggView6909124655948837579 as select v22, SUM(annot) as annot from aggJoin8256130774849626923 group by v22;
# 2. aggJoin
create or replace view aggJoin505563602918453900 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView6909124655948837579 where Comment_hasTag_Tag.TagId=aggView6909124655948837579.v22;

# AggReduce3
# 1. aggView
create or replace view aggView8146617210483668667 as select v20, SUM(annot) as annot from aggJoin505563602918453900 group by v20;
# 2. aggJoin
create or replace view aggJoin3506849104851115399 as select replyOf_PostId as v18, annot from Comment as Comment, aggView8146617210483668667 where Comment.CommentId=aggView8146617210483668667.v20;

# AggReduce4
# 1. aggView
create or replace view aggView6405361230651407680 as select v18, SUM(annot) as annot from aggJoin3506849104851115399 group by v18;
# 2. aggJoin
create or replace view aggJoin3877943469837331195 as select Forum_containerOfId as v9, annot from Post as Post, aggView6405361230651407680 where Post.PostId=aggView6405361230651407680.v18;

# AggReduce5
# 1. aggView
create or replace view aggView2823453184925408555 as select v9, SUM(annot) as annot from aggJoin3877943469837331195 group by v9;
# 2. aggJoin
create or replace view aggJoin4013722354668503335 as select ForumId as v9, annot from Forum as Forum, aggView2823453184925408555 where Forum.ForumId=aggView2823453184925408555.v9;

# AggReduce6
# 1. aggView
create or replace view aggView2841660394380029722 as select v9, SUM(annot) as annot from aggJoin4013722354668503335 group by v9;
# 2. aggJoin
create or replace view aggJoin8081462940779503797 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView2841660394380029722 where Forum_hasMember_Person.ForumId=aggView2841660394380029722.v9;

# AggReduce7
# 1. aggView
create or replace view aggView7518346252379030080 as select v8, SUM(annot) as annot from aggJoin8081462940779503797 group by v8;
# 2. aggJoin
create or replace view aggJoin4050652465395823223 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView7518346252379030080 where Person.PersonId=aggView7518346252379030080.v8;

# AggReduce8
# 1. aggView
create or replace view aggView5483594010126878176 as select v6, SUM(annot) as annot from aggJoin4050652465395823223 group by v6;
# 2. aggJoin
create or replace view aggJoin2324407373713954428 as select aggJoin2764717098297434901.annot * aggView5483594010126878176.annot as annot from aggJoin2764717098297434901 join aggView5483594010126878176 using(v6);
# Final result: 
select SUM(annot) as v26 from aggJoin2324407373713954428;

# drop view aggView482380879204014149, aggJoin2764717098297434901, aggView8585058616649138115, aggJoin8256130774849626923, aggView6909124655948837579, aggJoin505563602918453900, aggView8146617210483668667, aggJoin3506849104851115399, aggView6405361230651407680, aggJoin3877943469837331195, aggView2823453184925408555, aggJoin4013722354668503335, aggView2841660394380029722, aggJoin8081462940779503797, aggView7518346252379030080, aggJoin4050652465395823223, aggView5483594010126878176, aggJoin2324407373713954428;
