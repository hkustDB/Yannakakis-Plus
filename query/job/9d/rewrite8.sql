create or replace view aggJoin1959564590909690346 as (
with aggView834877564915625668 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView834877564915625668 where an.person_id=aggView834877564915625668.v35);
create or replace view aggJoin2627413421154695545 as (
with aggView9172688559077520974 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin1959564590909690346 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView9172688559077520974 where ci.person_id=aggView9172688559077520974.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin632195572825723512 as (
with aggView1350800241486422912 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58 from aggJoin2627413421154695545 join aggView1350800241486422912 using(v22));
create or replace view aggJoin3823745532782274688 as (
with aggView713339530865872201 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView713339530865872201 where mc.company_id=aggView713339530865872201.v32);
create or replace view aggJoin7792020450613114167 as (
with aggView897115947195919796 as (select v18 from aggJoin3823745532782274688 group by v18)
select id as v18, title as v47 from title as t, aggView897115947195919796 where t.id=aggView897115947195919796.v18);
create or replace view aggJoin111378581989848093 as (
with aggView8009176936692518769 as (select v18, MIN(v47) as v61 from aggJoin7792020450613114167 group by v18)
select v9, v20, v60 as v60, v58 as v58, v61 from aggJoin632195572825723512 join aggView8009176936692518769 using(v18));
create or replace view aggJoin5714499656238171928 as (
with aggView8803876011956223332 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin111378581989848093 group by v9,v60,v58,v61)
select name as v10, v60, v58, v61 from char_name as chn, aggView8803876011956223332 where chn.id=aggView8803876011956223332.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin5714499656238171928;
