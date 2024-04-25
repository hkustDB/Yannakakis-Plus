create or replace view semiJoinView5954278063102787873 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2770384980040924251 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8599671768431125241 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2770384980040924251);
create or replace view semiJoinView3551885687747150570 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8599671768431125241);
create or replace view semiJoinView6097433263357133064 as select v26, v3 from semiJoinView3551885687747150570 where (v3) in (select (v3) from semiJoinView5954278063102787873);
create or replace view semiJoinView2088285874119332230 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6097433263357133064) and name LIKE 'X%';
create or replace view nAux32 as select v27 from semiJoinView2088285874119332230;
select distinct v27 from nAux32;
