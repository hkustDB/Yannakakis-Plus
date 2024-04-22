create or replace view aggJoin479225066873458754 as (
with aggView1180550649029022435 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView1180550649029022435 where mk.keyword_id=aggView1180550649029022435.v24);
create or replace view aggJoin6507716964569396344 as (
with aggView6145124684432790947 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView6145124684432790947 where mc.company_id=aggView6145124684432790947.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin6474747806300000984 as (
with aggView8018361460314906179 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView8018361460314906179 where t.id=aggView8018361460314906179.v40 and production_year>2000);
create or replace view aggView5280742762618340350 as select v41, v40 from aggJoin6474747806300000984 group by v41,v40;
create or replace view aggJoin8802906521360260109 as (
with aggView2012156713489681343 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin6507716964569396344 join aggView2012156713489681343 using(v20));
create or replace view aggJoin2834206588150278645 as (
with aggView6825757594586190477 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6825757594586190477 where mi.info_type_id=aggView6825757594586190477.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1594426324604309999 as (
with aggView1882565601257706687 as (select v40 from aggJoin8802906521360260109 group by v40)
select v40 from aggJoin479225066873458754 join aggView1882565601257706687 using(v40));
create or replace view aggJoin5177021479148494855 as (
with aggView5627083901324034516 as (select v40 from aggJoin1594426324604309999 group by v40)
select v40, v35, v36 from aggJoin2834206588150278645 join aggView5627083901324034516 using(v40));
create or replace view aggView2295226817146607178 as select v35, v40 from aggJoin5177021479148494855 group by v35,v40;
create or replace view aggJoin6495135187054898697 as (
with aggView3053210284794404002 as (select v40, MIN(v41) as v53 from aggView5280742762618340350 group by v40)
select v35, v53 from aggView2295226817146607178 join aggView3053210284794404002 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin6495135187054898697;
