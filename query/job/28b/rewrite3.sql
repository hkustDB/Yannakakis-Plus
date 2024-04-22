create or replace view aggView4395259374720848922 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin446532454470297747 as (
with aggView6397947548788257767 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6397947548788257767 where mi_idx.info_type_id=aggView6397947548788257767.v20 and info>'6.5');
create or replace view aggJoin4123851075800010232 as (
with aggView4802423355030023096 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4802423355030023096 where cc.status_id=aggView4802423355030023096.v7);
create or replace view aggJoin4192460797847186595 as (
with aggView7369645543511105825 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7369645543511105825 where t.kind_id=aggView7369645543511105825.v25 and production_year>2005);
create or replace view aggView3516358978023990886 as select v46, v45 from aggJoin4192460797847186595 group by v46,v45;
create or replace view aggJoin2719935850528745805 as (
with aggView8496636736023270004 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin4123851075800010232 join aggView8496636736023270004 using(v5));
create or replace view aggJoin7354057491902263593 as (
with aggView1489943287566210450 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1489943287566210450 where mi.info_type_id=aggView1489943287566210450.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin212933510668691400 as (
with aggView8446434065848003063 as (select v45 from aggJoin7354057491902263593 group by v45)
select v45, v40 from aggJoin446532454470297747 join aggView8446434065848003063 using(v45));
create or replace view aggJoin8598262227788621912 as (
with aggView6980895981681977203 as (select v45 from aggJoin2719935850528745805 group by v45)
select v45, v40 from aggJoin212933510668691400 join aggView6980895981681977203 using(v45));
create or replace view aggView6924058099527396144 as select v45, v40 from aggJoin8598262227788621912 group by v45,v40;
create or replace view aggJoin550852997169862590 as (
with aggView8581341854969596639 as (select v45, MIN(v46) as v59 from aggView3516358978023990886 group by v45)
select v45, v40, v59 from aggView6924058099527396144 join aggView8581341854969596639 using(v45));
create or replace view aggJoin2747858194209995990 as (
with aggView6133450971040125397 as (select v9, MIN(v10) as v57 from aggView4395259374720848922 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6133450971040125397 where mc.company_id=aggView6133450971040125397.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4785851440835168647 as (
with aggView1651857956216317892 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2747858194209995990 join aggView1651857956216317892 using(v16));
create or replace view aggJoin6494105922742956901 as (
with aggView8414149121194282719 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView8414149121194282719 where mk.keyword_id=aggView8414149121194282719.v22);
create or replace view aggJoin8848179702306035668 as (
with aggView7195781268843036370 as (select v45 from aggJoin6494105922742956901 group by v45)
select v45, v31, v57 as v57 from aggJoin4785851440835168647 join aggView7195781268843036370 using(v45));
create or replace view aggJoin1096574582232268031 as (
with aggView3822679852391729502 as (select v45, MIN(v57) as v57 from aggJoin8848179702306035668 group by v45,v57)
select v40, v59 as v59, v57 from aggJoin550852997169862590 join aggView3822679852391729502 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin1096574582232268031;
