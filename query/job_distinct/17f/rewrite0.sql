create or replace view semiJoinView965297998279925161 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6099747630005264045 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7439486321452071277 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView6099747630005264045);
create or replace view semiJoinView1921557499578357230 as select v3, v20 from semiJoinView965297998279925161 where (v3) in (select (v3) from semiJoinView7439486321452071277);
create or replace view semiJoinView5805364437818560585 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1921557499578357230);
create or replace view semiJoinView675989460476986203 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5805364437818560585) and name LIKE '%B%';
create or replace view nAux24 as select v27 from semiJoinView675989460476986203;
select distinct v27 from nAux24;
