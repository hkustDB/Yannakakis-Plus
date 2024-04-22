create or replace view aggView4790883389866730209 as select name as v2, id as v1 from char_name as chn;
create or replace view aggJoin3104703585856180505 as (
with aggView9028851283747177089 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView9028851283747177089 where mc.company_type_id=aggView9028851283747177089.v22);
create or replace view aggJoin5427095855973976613 as (
with aggView6884233774876584658 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin3104703585856180505 join aggView6884233774876584658 using(v15));
create or replace view aggJoin6754258256644477628 as (
with aggView6523781928614932846 as (select v31 from aggJoin5427095855973976613 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView6523781928614932846 where t.id=aggView6523781928614932846.v31 and production_year>2005);
create or replace view aggView5465159038155311333 as select v31, v32 from aggJoin6754258256644477628 group by v31,v32;
create or replace view aggJoin6930690630343961738 as (
with aggView7924870481031559095 as (select v1, MIN(v2) as v43 from aggView4790883389866730209 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView7924870481031559095 where ci.person_role_id=aggView7924870481031559095.v1 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin4644187594723262413 as (
with aggView710629709147196015 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin6930690630343961738 join aggView710629709147196015 using(v29));
create or replace view aggJoin3410589939894074799 as (
with aggView5743233269585575585 as (select v31, MIN(v43) as v43 from aggJoin4644187594723262413 group by v31,v43)
select v32, v43 from aggView5465159038155311333 join aggView5743233269585575585 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin3410589939894074799;
