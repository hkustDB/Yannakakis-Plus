create or replace view aggJoin2708617500750123849 as (
with aggView2026372761237629903 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2026372761237629903 where mc.company_id=aggView2026372761237629903.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1449699499115219967 as (
with aggView3276886026243845126 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3276886026243845126 where mi_idx.info_type_id=aggView3276886026243845126.v20 and info>'6.5');
create or replace view aggJoin4134891202028477016 as (
with aggView1219482391404319094 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1219482391404319094 where cc.status_id=aggView1219482391404319094.v7);
create or replace view aggJoin1415243736959181760 as (
with aggView8358843145258351302 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2708617500750123849 join aggView8358843145258351302 using(v16));
create or replace view aggJoin7946674462853966590 as (
with aggView592571273709868757 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView592571273709868757 where t.kind_id=aggView592571273709868757.v25 and production_year>2005);
create or replace view aggJoin8396712978429946650 as (
with aggView4559803140861106941 as (select v45, MIN(v46) as v59 from aggJoin7946674462853966590 group by v45)
select v45, v40, v59 from aggJoin1449699499115219967 join aggView4559803140861106941 using(v45));
create or replace view aggJoin5358506763255706446 as (
with aggView5204719359177765834 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin4134891202028477016 join aggView5204719359177765834 using(v5));
create or replace view aggJoin8124384849645660435 as (
with aggView8356674614821740052 as (select v45 from aggJoin5358506763255706446 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView8356674614821740052 where mi.movie_id=aggView8356674614821740052.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin3361968996418411023 as (
with aggView6849102034690391920 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin8124384849645660435 join aggView6849102034690391920 using(v18));
create or replace view aggJoin908483418425897079 as (
with aggView4772531673695745580 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4772531673695745580 where mk.keyword_id=aggView4772531673695745580.v22);
create or replace view aggJoin2548241524187980633 as (
with aggView8805008678919688682 as (select v45, MIN(v57) as v57 from aggJoin1415243736959181760 group by v45,v57)
select v45, v35, v57 from aggJoin3361968996418411023 join aggView8805008678919688682 using(v45));
create or replace view aggJoin7711155627610083588 as (
with aggView8842264839082457007 as (select v45, MIN(v57) as v57 from aggJoin2548241524187980633 group by v45,v57)
select v45, v40, v59 as v59, v57 from aggJoin8396712978429946650 join aggView8842264839082457007 using(v45));
create or replace view aggJoin1964846367243166256 as (
with aggView1004685533693126339 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v40) as v58 from aggJoin7711155627610083588 group by v45,v59,v57)
select v59, v57, v58 from aggJoin908483418425897079 join aggView1004685533693126339 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1964846367243166256;
