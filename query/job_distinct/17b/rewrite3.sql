create or replace view semiJoinView3237150211628159873 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2015161707084632209 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8949464165752240317 as select v3, v25 from semiJoinView2015161707084632209 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView9158150928154327267 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3237150211628159873);
create or replace view semiJoinView3928310252472756299 as select v26, v3 from semiJoinView9158150928154327267 where (v3) in (select (v3) from semiJoinView8949464165752240317);
create or replace view semiJoinView2211130906305654898 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3928310252472756299);
create or replace view nAux54 as select v27 from semiJoinView2211130906305654898;
select distinct v27 from nAux54;
