create or replace view aggView9052185641986755172 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin5001628420480616504 as (
with aggView7792301384103655886 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7792301384103655886 where mk.keyword_id=aggView7792301384103655886.v22);
create or replace view aggJoin1508879982511950599 as (
with aggView2557849727177241085 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView2557849727177241085 where mc.company_type_id=aggView2557849727177241085.v18);
create or replace view aggJoin3062696653690964692 as (
with aggView8303793252331413646 as (select v24 from aggJoin5001628420480616504 group by v24)
select v24, v17, v19 from aggJoin1508879982511950599 join aggView8303793252331413646 using(v24));
create or replace view aggView7497931846536840910 as select v19, v24, v17 from aggJoin3062696653690964692 group by v19,v24,v17;
create or replace view aggJoin4917939723757844895 as (
with aggView331297176475606961 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView331297176475606961 where ml.link_type_id=aggView331297176475606961.v13);
create or replace view aggJoin8576619408354763193 as (
with aggView6719665030978870037 as (select v24 from aggJoin4917939723757844895 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView6719665030978870037 where t.id=aggView6719665030978870037.v24 and production_year>1950);
create or replace view aggView8271362845388702385 as select v28, v24 from aggJoin8576619408354763193 group by v28,v24;
create or replace view aggJoin5463535759903637043 as (
with aggView8847301137144101979 as (select v17, MIN(v2) as v39 from aggView9052185641986755172 group by v17)
select v19, v24, v39 from aggView7497931846536840910 join aggView8847301137144101979 using(v17));
create or replace view aggJoin7998361764537669825 as (
with aggView7152192702903197450 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin5463535759903637043 group by v24,v39)
select v28, v39, v40 from aggView8271362845388702385 join aggView7152192702903197450 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin7998361764537669825;
