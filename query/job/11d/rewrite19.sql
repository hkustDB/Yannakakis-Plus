create or replace view aggJoin8392917360568328151 as (
with aggView1348793843976490552 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView1348793843976490552 where mc.company_id=aggView1348793843976490552.v17);
create or replace view aggJoin511362797900293243 as (
with aggView8331308711580729713 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView8331308711580729713 where mk.keyword_id=aggView8331308711580729713.v22);
create or replace view aggJoin1611346916059930364 as (
with aggView6231141672376472138 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin8392917360568328151 join aggView6231141672376472138 using(v18));
create or replace view aggJoin3867129220492551746 as (
with aggView1110754699900832826 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin1611346916059930364 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView1110754699900832826 where t.id=aggView1110754699900832826.v24 and production_year>1950);
create or replace view aggJoin7464276769050975824 as (
with aggView7727542334275324605 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin3867129220492551746 group by v24,v39,v40)
select v24, v39, v40, v41 from aggJoin511362797900293243 join aggView7727542334275324605 using(v24));
create or replace view aggJoin4001332251203508475 as (
with aggView4474082031503556084 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView4474082031503556084 where ml.link_type_id=aggView4474082031503556084.v13);
create or replace view aggJoin600596728310368686 as (
with aggView1657567900436650573 as (select v24 from aggJoin4001332251203508475 group by v24)
select v39 as v39, v40 as v40, v41 as v41 from aggJoin7464276769050975824 join aggView1657567900436650573 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin600596728310368686;
