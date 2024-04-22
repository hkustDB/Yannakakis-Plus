create or replace view aggView2434133105548547679 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin3058061361754485819 as (
with aggView7395854766768027105 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7395854766768027105 where mk.keyword_id=aggView7395854766768027105.v22);
create or replace view aggJoin2465422238651962599 as (
with aggView4515509593122546659 as (select v24 from aggJoin3058061361754485819 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView4515509593122546659 where ml.movie_id=aggView4515509593122546659.v24);
create or replace view aggJoin3093517815394803929 as (
with aggView1053784976023464059 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView1053784976023464059 where mc.company_type_id=aggView1053784976023464059.v18);
create or replace view aggView5379747079650726196 as select v19, v24, v17 from aggJoin3093517815394803929 group by v19,v24,v17;
create or replace view aggJoin7949915851586247009 as (
with aggView8801207145895638595 as (select id as v13 from link_type as lt)
select v24 from aggJoin2465422238651962599 join aggView8801207145895638595 using(v13));
create or replace view aggJoin5340032849531858010 as (
with aggView358371316131725353 as (select v24 from aggJoin7949915851586247009 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView358371316131725353 where t.id=aggView358371316131725353.v24 and production_year>1950);
create or replace view aggView5614233044177132749 as select v24, v28 from aggJoin5340032849531858010 group by v24,v28;
create or replace view aggJoin8884065522741901654 as (
with aggView7880331687338141073 as (select v17, MIN(v2) as v39 from aggView2434133105548547679 group by v17)
select v19, v24, v39 from aggView5379747079650726196 join aggView7880331687338141073 using(v17));
create or replace view aggJoin7886551153239934926 as (
with aggView3627771808914124003 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin8884065522741901654 group by v24,v39)
select v28, v39, v40 from aggView5614233044177132749 join aggView3627771808914124003 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin7886551153239934926;
