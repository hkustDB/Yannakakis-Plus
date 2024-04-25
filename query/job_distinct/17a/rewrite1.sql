create or replace view semiJoinView2672093362936861093 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2242824860480378112 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView2041585885457340626 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2672093362936861093);
create or replace view semiJoinView5102706270295529864 as select v3, v20 from semiJoinView2242824860480378112 where (v3) in (select (v3) from semiJoinView2041585885457340626);
create or replace view semiJoinView5051723059755602133 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5102706270295529864);
create or replace view semiJoinView3834620312462227468 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5051723059755602133);
create or replace view nAux64 as select v27 from semiJoinView3834620312462227468;
select distinct v27 from nAux64;
