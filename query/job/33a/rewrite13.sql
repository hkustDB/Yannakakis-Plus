create or replace view aggView7475289201824904573 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView9117306901814656593 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin2213275690648831541 as (
with aggView6384915078661542175 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView6384915078661542175 where t2.kind_id=aggView6384915078661542175.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView6745693818817076803 as select v61, v62 from aggJoin2213275690648831541 group by v61,v62;
create or replace view aggJoin5404121965743413229 as (
with aggView5947848293459861104 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView5947848293459861104 where t1.kind_id=aggView5947848293459861104.v19);
create or replace view aggView6651013179228480602 as select v49, v50 from aggJoin5404121965743413229 group by v49,v50;
create or replace view aggJoin681014019336901805 as (
with aggView7814077901702993514 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7814077901702993514 where mi_idx2.info_type_id=aggView7814077901702993514.v17 and info<'3.0');
create or replace view aggView5598185598425480969 as select v61, v43 from aggJoin681014019336901805 group by v61,v43;
create or replace view aggJoin8863364818112975874 as (
with aggView8275447594278290962 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8275447594278290962 where mi_idx1.info_type_id=aggView8275447594278290962.v15);
create or replace view aggView819169760758589610 as select v49, v38 from aggJoin8863364818112975874 group by v49,v38;
create or replace view aggJoin2616276383534293558 as (
with aggView8183139060572102867 as (select v49, MIN(v50) as v77 from aggView6651013179228480602 group by v49)
select v49, v38, v77 from aggView819169760758589610 join aggView8183139060572102867 using(v49));
create or replace view aggJoin6972097333134585665 as (
with aggView7262270126793092780 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin2616276383534293558 group by v49,v77)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77, v75 from movie_link as ml, aggView7262270126793092780 where ml.movie_id=aggView7262270126793092780.v49);
create or replace view aggJoin774453253643087165 as (
with aggView1870230433239850479 as (select v1, MIN(v2) as v73 from aggView9117306901814656593 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView1870230433239850479 where mc1.company_id=aggView1870230433239850479.v1);
create or replace view aggJoin3984856092500246238 as (
with aggView1635051998824141251 as (select v61, MIN(v43) as v76 from aggView5598185598425480969 group by v61)
select v61, v62, v76 from aggView6745693818817076803 join aggView1635051998824141251 using(v61));
create or replace view aggJoin6730811596172662856 as (
with aggView5173688035822814004 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin3984856092500246238 group by v61,v76)
select v49, v61, v23, v77 as v77, v75 as v75, v76, v78 from aggJoin6972097333134585665 join aggView5173688035822814004 using(v61));
create or replace view aggJoin8342415517486125041 as (
with aggView4532916380155532124 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v77, v75, v76, v78 from aggJoin6730811596172662856 join aggView4532916380155532124 using(v23));
create or replace view aggJoin3696766591598868224 as (
with aggView5771358808021134671 as (select v49, MIN(v73) as v73 from aggJoin774453253643087165 group by v49,v73)
select v61, v77 as v77, v75 as v75, v76 as v76, v78 as v78, v73 from aggJoin8342415517486125041 join aggView5771358808021134671 using(v49));
create or replace view aggJoin2133514721692983984 as (
with aggView8548993532069801911 as (select v61, MIN(v77) as v77, MIN(v75) as v75, MIN(v76) as v76, MIN(v78) as v78, MIN(v73) as v73 from aggJoin3696766591598868224 group by v61,v73,v75,v77,v76,v78)
select company_id as v8, v77, v75, v76, v78, v73 from movie_companies as mc2, aggView8548993532069801911 where mc2.movie_id=aggView8548993532069801911.v61);
create or replace view aggJoin3402433410123490824 as (
with aggView6458136050522101599 as (select v8, MIN(v77) as v77, MIN(v75) as v75, MIN(v76) as v76, MIN(v78) as v78, MIN(v73) as v73 from aggJoin2133514721692983984 group by v8,v73,v75,v77,v76,v78)
select v9, v77, v75, v76, v78, v73 from aggView7475289201824904573 join aggView6458136050522101599 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3402433410123490824;
