create or replace view semiJoinView5189934980817357171 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view semiJoinView5185554071748224281 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view semiJoinView3677577468835634880 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView5189934980817357171) and production_year>2005;
create or replace view semiJoinView1730177416534134154 as select v15, v16, v19 from semiJoinView3677577468835634880 where (v15) in (select (v15) from semiJoinView5185554071748224281);
create or replace view tAux44 as select v16 from semiJoinView1730177416534134154;
select distinct v16 from tAux44;
