create or replace view aggView8117848941816533586 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6870075125481321112 as select movie_id as v12 from movie_keyword as mk, aggView8117848941816533586 where mk.keyword_id=aggView8117848941816533586.v18;
create or replace view aggView1087601658521699910 as select v12, COUNT(*) as annot from aggJoin6870075125481321112 group by v12;
create or replace view aggJoin3986171069479005953 as select id as v12, annot from title as t, aggView1087601658521699910 where t.id=aggView1087601658521699910.v12;
create or replace view aggView1216942746031763791 as select v12, SUM(annot) as annot from aggJoin3986171069479005953 group by v12;
create or replace view aggJoin5954143523798102035 as select company_id as v1, annot from movie_companies as mc, aggView1216942746031763791 where mc.movie_id=aggView1216942746031763791.v12;
create or replace view aggView4157524339573417174 as select v1, SUM(annot) as annot from aggJoin5954143523798102035 group by v1;
create or replace view aggJoin4284545592254050058 as select country_code as v3, annot from company_name as cn, aggView4157524339573417174 where cn.id=aggView4157524339573417174.v1 and country_code= '[nl]';
select SUM(annot) as v31 from aggJoin4284545592254050058;
