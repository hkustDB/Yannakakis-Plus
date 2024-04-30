create or replace view aggView5155681034957392558 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7077065261956437336 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5155681034957392558 where mc.movie_id=aggView5155681034957392558.v12;
create or replace view aggView6945917338365852894 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin3745897406836319983 as select v12, v31 from aggJoin7077065261956437336 join aggView6945917338365852894 using(v1);
create or replace view aggView5815311934532257431 as select v12, MIN(v31) as v31 from aggJoin3745897406836319983 group by v12;
create or replace view aggJoin4447756409362843946 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5815311934532257431 where mk.movie_id=aggView5815311934532257431.v12;
create or replace view aggView1843050444886035679 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin9188081679191851996 as select v31 from aggJoin4447756409362843946 join aggView1843050444886035679 using(v18);
select MIN(v31) as v31 from aggJoin9188081679191851996;
