create or replace view aggJoin3912977935208427077 as (
with aggView5021109725916082946 as (select id as v31, title as v44 from title as t where production_year>2005)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView5021109725916082946 where ci.movie_id=aggView5021109725916082946.v31 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin2187456897514545060 as (
with aggView1885014912165898525 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v1, v12, v44 from aggJoin3912977935208427077 join aggView1885014912165898525 using(v29));
create or replace view aggJoin775954662092951840 as (
with aggView5948481002472014896 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView5948481002472014896 where mc.company_type_id=aggView5948481002472014896.v22);
create or replace view aggJoin6239482000295463510 as (
with aggView648472046909935902 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin775954662092951840 join aggView648472046909935902 using(v15));
create or replace view aggJoin4349308532684161825 as (
with aggView9073589019069662806 as (select v31 from aggJoin6239482000295463510 group by v31)
select v1, v12, v44 as v44 from aggJoin2187456897514545060 join aggView9073589019069662806 using(v31));
create or replace view aggJoin1517433924112660313 as (
with aggView3662859218635952148 as (select v1, MIN(v44) as v44 from aggJoin4349308532684161825 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView3662859218635952148 where chn.id=aggView3662859218635952148.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin1517433924112660313;
