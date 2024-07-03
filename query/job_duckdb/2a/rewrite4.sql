create or replace view aggView5775054278515074680 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin3156070324949879681 as select movie_id as v12 from movie_companies as mc, aggView5775054278515074680 where mc.company_id=aggView5775054278515074680.v1;
create or replace view aggView9089350402246227516 as select v12 from aggJoin3156070324949879681 group by v12;
create or replace view aggJoin523143165339259967 as select id as v12, title as v20 from title as t, aggView9089350402246227516 where t.id=aggView9089350402246227516.v12;
create or replace view aggView3895946521590507537 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1373757136583409774 as select movie_id as v12 from movie_keyword as mk, aggView3895946521590507537 where mk.keyword_id=aggView3895946521590507537.v18;
create or replace view aggView1764566758228981224 as select v12, MIN(v20) as v31 from aggJoin523143165339259967 group by v12;
create or replace view aggJoin3290417398608848627 as select v31 from aggJoin1373757136583409774 join aggView1764566758228981224 using(v12);
select MIN(v31) as v31 from aggJoin3290417398608848627;
