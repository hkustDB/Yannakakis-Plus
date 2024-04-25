create or replace view semiJoinView5486304496329547997 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view semiJoinView6422189218514583141 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view semiJoinView1344449072676833399 as select v15, v1, v9 from semiJoinView6422189218514583141 where (v15) in (select (v15) from semiJoinView5486304496329547997);
create or replace view semiJoinView8789701731884892606 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView1344449072676833399) and production_year>2005;
create or replace view tAux8 as select v16 from semiJoinView8789701731884892606;
select distinct v16 from tAux8;
