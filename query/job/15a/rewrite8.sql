create or replace view aggView6745995969950406509 as select title as v41, id as v40 from title as t where production_year>2000;
create or replace view aggJoin4185627773022142123 as (
with aggView7079673433167859297 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7079673433167859297 where mk.keyword_id=aggView7079673433167859297.v24);
create or replace view aggJoin4041061241300038620 as (
with aggView5153237451245530365 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView5153237451245530365 where mc.company_id=aggView5153237451245530365.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin357301522164667071 as (
with aggView5057181006382104706 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin4041061241300038620 join aggView5057181006382104706 using(v20));
create or replace view aggJoin4868959689174497749 as (
with aggView5096647401837060454 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5096647401837060454 where mi.info_type_id=aggView5096647401837060454.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin2291587577347786298 as (
with aggView7515648027891658862 as (select v40 from aggJoin4185627773022142123 group by v40)
select v40, v35, v36 from aggJoin4868959689174497749 join aggView7515648027891658862 using(v40));
create or replace view aggJoin3009728547033549858 as (
with aggView8365867881147603861 as (select v40 from aggJoin357301522164667071 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView8365867881147603861 where aka_t.movie_id=aggView8365867881147603861.v40);
create or replace view aggJoin5944330469094493727 as (
with aggView3883535221653038544 as (select v40 from aggJoin3009728547033549858 group by v40)
select v40, v35, v36 from aggJoin2291587577347786298 join aggView3883535221653038544 using(v40));
create or replace view aggView2707294559674292045 as select v35, v40 from aggJoin5944330469094493727 group by v35,v40;
create or replace view aggJoin1532769414067883467 as (
with aggView1855070343290432756 as (select v40, MIN(v41) as v53 from aggView6745995969950406509 group by v40)
select v35, v53 from aggView2707294559674292045 join aggView1855070343290432756 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin1532769414067883467;
