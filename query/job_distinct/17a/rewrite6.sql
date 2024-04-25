create or replace view semiJoinView4106958835503114786 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView6349154137240207932 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView4106958835503114786);
create or replace view semiJoinView4229019000683862422 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2010192544533027124 as select v3, v25 from semiJoinView4229019000683862422 where (v3) in (select (v3) from semiJoinView6349154137240207932);
create or replace view semiJoinView7951164026077918541 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView2010192544533027124);
create or replace view semiJoinView6310154632092391547 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView7951164026077918541);
create or replace view nAux18 as select v27 from semiJoinView6310154632092391547;
select distinct v27 from nAux18;
