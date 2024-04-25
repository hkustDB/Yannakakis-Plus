create or replace view semiJoinView8111779466588521808 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView3338804047394745149 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8111779466588521808);
create or replace view semiJoinView688203386185444746 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (v3) from semiJoinView3338804047394745149);
create or replace view semiJoinView4579451556169852000 as select v3, v25 from semiJoinView688203386185444746 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6127130416199630746 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4579451556169852000);
create or replace view semiJoinView4968337957989828645 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6127130416199630746);
create or replace view nAux80 as select v27 from semiJoinView4968337957989828645;
select distinct v27 from nAux80;
