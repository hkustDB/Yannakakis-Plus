create or replace view semiJoinView3116729382072308972 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4430381920313836091 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView6131812069288462132 as select v3, v20 from semiJoinView4430381920313836091 where (v3) in (select (v3) from semiJoinView3116729382072308972);
create or replace view semiJoinView1133146308291127614 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView6131812069288462132);
create or replace view semiJoinView2055127557688741985 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1133146308291127614);
create or replace view semiJoinView8063614315484261863 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2055127557688741985);
create or replace view nAux56 as select v27 from semiJoinView8063614315484261863;
select distinct v27 from nAux56;
