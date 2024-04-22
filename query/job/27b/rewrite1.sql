create or replace view aggView1413808394070198208 as select id as v37, title as v41 from title as t where production_year= 1998;
create or replace view aggView7518074177504682596 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin2776528295654323281 as (
with aggView33673664437784817 as (select v25, MIN(v10) as v52 from aggView7518074177504682596 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView33673664437784817 where mc.company_id=aggView33673664437784817.v25);
create or replace view aggJoin4158328316553549332 as (
with aggView3530624084869462861 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView3530624084869462861 where ml.link_type_id=aggView3530624084869462861.v21);
create or replace view aggJoin4489193219895078184 as (
with aggView257207966498835319 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView257207966498835319 where cc.subject_id=aggView257207966498835319.v5);
create or replace view aggJoin3415334740605508374 as (
with aggView3832046139716708527 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView3832046139716708527 where mk.keyword_id=aggView3832046139716708527.v35);
create or replace view aggJoin8245098953305917133 as (
with aggView5394740493482207240 as (select v37 from aggJoin3415334740605508374 group by v37)
select v37, v7 from aggJoin4489193219895078184 join aggView5394740493482207240 using(v37));
create or replace view aggJoin2309749482594298480 as (
with aggView6460698758618213358 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin8245098953305917133 join aggView6460698758618213358 using(v7));
create or replace view aggJoin6384037659950987887 as (
with aggView9147445830239229113 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select v37, v53 as v53 from aggJoin4158328316553549332 join aggView9147445830239229113 using(v37));
create or replace view aggJoin8028167979145362779 as (
with aggView1648785184366273272 as (select v37, MIN(v53) as v53 from aggJoin6384037659950987887 group by v37,v53)
select v37, v41, v53 from aggView1413808394070198208 join aggView1648785184366273272 using(v37));
create or replace view aggJoin5829111769621646936 as (
with aggView2088170816151116088 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin2776528295654323281 join aggView2088170816151116088 using(v26));
create or replace view aggJoin7410170052850092349 as (
with aggView983358067239573174 as (select v37 from aggJoin2309749482594298480 group by v37)
select v37, v52 as v52 from aggJoin5829111769621646936 join aggView983358067239573174 using(v37));
create or replace view aggJoin484174535372726409 as (
with aggView8228706132010783078 as (select v37, MIN(v52) as v52 from aggJoin7410170052850092349 group by v37,v52)
select v41, v53 as v53, v52 from aggJoin8028167979145362779 join aggView8228706132010783078 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin484174535372726409;
