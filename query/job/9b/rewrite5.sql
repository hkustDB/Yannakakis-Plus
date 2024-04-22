create or replace view aggView8038147177456679253 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView132705712290993066 as select title as v47, id as v18 from title as t where production_year>=2007 and production_year<=2010;
create or replace view aggJoin2994236682053839295 as (
with aggView2406223705271457251 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView2406223705271457251 where v36 LIKE '%Angel%');
create or replace view aggView2353724284709519409 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin4756741097990425728 as (
with aggView2416221088818767089 as (select v18, MIN(v47) as v61 from aggView132705712290993066 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView2416221088818767089 where ci.movie_id=aggView2416221088818767089.v18 and note= '(voice)');
create or replace view aggJoin5684687085489396776 as (
with aggView6868977848887428631 as (select v35, MIN(v36) as v60 from aggJoin2994236682053839295 group by v35)
select v3, v35, v60 from aggView2353724284709519409 join aggView6868977848887428631 using(v35));
create or replace view aggJoin2314576074764420535 as (
with aggView4468524767111820441 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin5684687085489396776 group by v35,v60)
select v18, v9, v20, v22, v61 as v61, v60, v58 from aggJoin4756741097990425728 join aggView4468524767111820441 using(v35));
create or replace view aggJoin3530731401012862102 as (
with aggView178104253677800979 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v61, v60, v58 from aggJoin2314576074764420535 join aggView178104253677800979 using(v22));
create or replace view aggJoin5257832450889190248 as (
with aggView4702075901664166170 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView4702075901664166170 where mc.company_id=aggView4702075901664166170.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin4284594505009966572 as (
with aggView6399535680649875673 as (select v18 from aggJoin5257832450889190248 group by v18)
select v9, v20, v61 as v61, v60 as v60, v58 as v58 from aggJoin3530731401012862102 join aggView6399535680649875673 using(v18));
create or replace view aggJoin290322339745608601 as (
with aggView1281932050656732404 as (select v9, MIN(v61) as v61, MIN(v60) as v60, MIN(v58) as v58 from aggJoin4284594505009966572 group by v9,v58,v60,v61)
select v10, v61, v60, v58 from aggView8038147177456679253 join aggView1281932050656732404 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin290322339745608601;
