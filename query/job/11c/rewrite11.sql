create or replace view aggView5704782136759675236 as select title as v28, id as v24 from title as t where production_year>1950;
create or replace view aggView1199759270224704503 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin644439521780042705 as (
with aggView4968946829770303659 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView4968946829770303659 where mk.keyword_id=aggView4968946829770303659.v22);
create or replace view aggJoin982148333521156989 as (
with aggView3652573244124369823 as (select v24 from aggJoin644439521780042705 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView3652573244124369823 where ml.movie_id=aggView3652573244124369823.v24);
create or replace view aggJoin1311620427193527605 as (
with aggView1881863381389285392 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView1881863381389285392 where mc.company_type_id=aggView1881863381389285392.v18);
create or replace view aggJoin2484239656312978127 as (
with aggView3939687710161503015 as (select id as v13 from link_type as lt)
select v24 from aggJoin982148333521156989 join aggView3939687710161503015 using(v13));
create or replace view aggJoin5569037201777997037 as (
with aggView1997918790463680599 as (select v24 from aggJoin2484239656312978127 group by v24)
select v24, v17, v19 from aggJoin1311620427193527605 join aggView1997918790463680599 using(v24));
create or replace view aggView5807186664992765033 as select v19, v24, v17 from aggJoin5569037201777997037 group by v19,v24,v17;
create or replace view aggJoin6335007368065143482 as (
with aggView6975342951614030890 as (select v17, MIN(v2) as v39 from aggView1199759270224704503 group by v17)
select v19, v24, v39 from aggView5807186664992765033 join aggView6975342951614030890 using(v17));
create or replace view aggJoin4103245902377457061 as (
with aggView2560961585379657880 as (select v24, MIN(v28) as v41 from aggView5704782136759675236 group by v24)
select v19, v39 as v39, v41 from aggJoin6335007368065143482 join aggView2560961585379657880 using(v24));
select MIN(v39) as v39,MIN(v19) as v40,MIN(v41) as v41 from aggJoin4103245902377457061;
