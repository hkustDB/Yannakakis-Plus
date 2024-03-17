create or replace view aggView5161182912171946349 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5690677979420303457 as select movie_id as v12 from movie_keyword as mk, aggView5161182912171946349 where mk.keyword_id=aggView5161182912171946349.v1;
create or replace view aggView1740645685945669437 as select v12 from aggJoin5690677979420303457 group by v12;
create or replace view aggJoin5575144340605402615 as select id as v12, title as v13 from title as t, aggView1740645685945669437 where t.id=aggView1740645685945669437.v12 and production_year>2010;
create or replace view aggView1195141311053717144 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8400072997691487586 as select v13 from aggJoin5575144340605402615 join aggView1195141311053717144 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin8400072997691487586;
select sum(v24) from res;