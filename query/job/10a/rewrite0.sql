create or replace view aggView3009816672772386623 as select name as v2, id as v1 from char_name as chn;
create or replace view aggJoin7176450080818388923 as (
with aggView1528921031545092525 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView1528921031545092525 where mc.company_type_id=aggView1528921031545092525.v22);
create or replace view aggJoin8734268117174367991 as (
with aggView702240676282355644 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin7176450080818388923 join aggView702240676282355644 using(v15));
create or replace view aggJoin8687511374580687666 as (
with aggView7726246961757648220 as (select v31 from aggJoin8734268117174367991 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView7726246961757648220 where t.id=aggView7726246961757648220.v31 and production_year>2005);
create or replace view aggView1813014991329365873 as select v31, v32 from aggJoin8687511374580687666 group by v31,v32;
create or replace view aggJoin1764560557043152802 as (
with aggView5919585145736260017 as (select v31, MIN(v32) as v44 from aggView1813014991329365873 group by v31)
select person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView5919585145736260017 where ci.movie_id=aggView5919585145736260017.v31 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin1869590398896599498 as (
with aggView745486917405911650 as (select id as v29 from role_type as rt where role= 'actor')
select v1, v12, v44 from aggJoin1764560557043152802 join aggView745486917405911650 using(v29));
create or replace view aggJoin2512681376370603045 as (
with aggView7551234068933310008 as (select v1, MIN(v44) as v44 from aggJoin1869590398896599498 group by v1,v44)
select v2, v44 from aggView3009816672772386623 join aggView7551234068933310008 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin2512681376370603045;
