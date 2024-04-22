create or replace view aggView3742889008633581189 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8295546503174341930 as (
with aggView48632382055157210 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView48632382055157210 where mi_idx.info_type_id=aggView48632382055157210.v20 and info>'6.5');
create or replace view aggJoin3038102676573492244 as (
with aggView8185631797007794138 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView8185631797007794138 where cc.status_id=aggView8185631797007794138.v7);
create or replace view aggJoin7408603792176618793 as (
with aggView2173617437791574895 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2173617437791574895 where t.kind_id=aggView2173617437791574895.v25 and production_year>2005);
create or replace view aggJoin4331922418042577823 as (
with aggView802686152998106745 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3038102676573492244 join aggView802686152998106745 using(v5));
create or replace view aggJoin4497514544120019402 as (
with aggView1028821115756856984 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1028821115756856984 where mi.info_type_id=aggView1028821115756856984.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1481315494411379504 as (
with aggView892092167753030834 as (select v45 from aggJoin4497514544120019402 group by v45)
select v45, v40 from aggJoin8295546503174341930 join aggView892092167753030834 using(v45));
create or replace view aggView5601701524910179858 as select v45, v40 from aggJoin1481315494411379504 group by v45,v40;
create or replace view aggJoin8695611749340675832 as (
with aggView6430056884367179434 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6430056884367179434 where mk.keyword_id=aggView6430056884367179434.v22);
create or replace view aggJoin7750702302940195728 as (
with aggView8561081309121098635 as (select v45 from aggJoin8695611749340675832 group by v45)
select v45 from aggJoin4331922418042577823 join aggView8561081309121098635 using(v45));
create or replace view aggJoin833014713816683012 as (
with aggView9035923484808963819 as (select v45 from aggJoin7750702302940195728 group by v45)
select v45, v46, v49 from aggJoin7408603792176618793 join aggView9035923484808963819 using(v45));
create or replace view aggView6890482205076289475 as select v46, v45 from aggJoin833014713816683012 group by v46,v45;
create or replace view aggJoin1385741881161442039 as (
with aggView1937207482666178480 as (select v45, MIN(v40) as v58 from aggView5601701524910179858 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView1937207482666178480 where mc.movie_id=aggView1937207482666178480.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6058606458475089985 as (
with aggView4072128696221915426 as (select v9, MIN(v10) as v57 from aggView3742889008633581189 group by v9)
select v45, v16, v31, v58 as v58, v57 from aggJoin1385741881161442039 join aggView4072128696221915426 using(v9));
create or replace view aggJoin4439026036602635122 as (
with aggView7057712348166213780 as (select id as v16 from company_type as ct)
select v45, v31, v58, v57 from aggJoin6058606458475089985 join aggView7057712348166213780 using(v16));
create or replace view aggJoin5430325922713007538 as (
with aggView5659523958428726045 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin4439026036602635122 group by v45,v58,v57)
select v46, v58, v57 from aggView6890482205076289475 join aggView5659523958428726045 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin5430325922713007538;
