create or replace view aggView5388036154729245506 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2448083064042433257 as (
with aggView8429518826012097578 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView8429518826012097578 where mi.info_type_id=aggView8429518826012097578.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1597405239916597981 as (
with aggView5882516793554137590 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView5882516793554137590 where mk.keyword_id=aggView5882516793554137590.v14);
create or replace view aggJoin394164542896397103 as (
with aggView7774781593098621836 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7774781593098621836 where mi_idx.info_type_id=aggView7774781593098621836.v12 and info<'8.5');
create or replace view aggJoin9130501931684694943 as (
with aggView4452228643069592542 as (select v37 from aggJoin2448083064042433257 group by v37)
select v37 from aggJoin1597405239916597981 join aggView4452228643069592542 using(v37));
create or replace view aggJoin910829888508987742 as (
with aggView1743359585804003600 as (select v37 from aggJoin9130501931684694943 group by v37)
select v37, v32 from aggJoin394164542896397103 join aggView1743359585804003600 using(v37));
create or replace view aggView5883614928574440715 as select v32, v37 from aggJoin910829888508987742 group by v32,v37;
create or replace view aggJoin4088546402325391943 as (
with aggView5641973514316852970 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5641973514316852970 where t.kind_id=aggView5641973514316852970.v17 and production_year>2005);
create or replace view aggView8369668450980786106 as select v37, v38 from aggJoin4088546402325391943 group by v37,v38;
create or replace view aggJoin3212763440550363699 as (
with aggView7430815421819314884 as (select v1, MIN(v2) as v49 from aggView5388036154729245506 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView7430815421819314884 where mc.company_id=aggView7430815421819314884.v1);
create or replace view aggJoin446021475359939738 as (
with aggView658556667109026087 as (select v37, MIN(v38) as v51 from aggView8369668450980786106 group by v37)
select v32, v37, v51 from aggView5883614928574440715 join aggView658556667109026087 using(v37));
create or replace view aggJoin7735783271519986068 as (
with aggView3320970544827665824 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin3212763440550363699 join aggView3320970544827665824 using(v8));
create or replace view aggJoin6312815337903608674 as (
with aggView1483723431346980631 as (select v37, MIN(v49) as v49 from aggJoin7735783271519986068 group by v37,v49)
select v32, v51 as v51, v49 from aggJoin446021475359939738 join aggView1483723431346980631 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin6312815337903608674;
